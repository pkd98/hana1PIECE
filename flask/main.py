# -- coding: utf-8 --

'''
[Rest API]
    - [POST] 요청: 건물명, 위도, 경도, 평수, 현재 토큰 가격 (스프링 스케줄러 요청)
    - 문자열 평가 반환: 매우 저평가(-10%), 저평가(-5%), 적정가, 고평가(+5%), 매우 고평가(+10%)


[네이버 부동산 크롤링]
    대상 페이지) https://m.land.naver.com/map/{위도}:{경도}:18:/APT:OPST:GM/A1
              - 위도:경도:18:/APT:OPST:GM
              - 해당 페이지 크롤링
              - 대상 건물 평단가 추출

예시)
    ttl="건물명" -> <span class="pin_year _markerEnv">5,594만원</span> 금액 찾기
    5594 추출 -> 평당 55940000 * 입력 평수 => 현재 토큰가격 비교 평가
'''
import json
import time
from flask import Flask, request, jsonify, make_response
from flask_restx import Api, Resource
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By

app = Flask(__name__)  # Flask 객체 선언
api = Api(app, default_mediatype="application/json; charset=utf-8")  # Flask 객체에 Api 객체 등록


'''
크롤링 결과 데이터 정제
'''
def convert_currency_to_number(currency_str):
    if '만원' in currency_str:
        number = float(currency_str.replace('만원', '').replace(',', '')) * 10000
    elif '억' in currency_str:
        number = float(currency_str.replace('억', '').replace(',', '')) * 100000000
    else:
        number = float(currency_str.replace(',', ''))
    return int(number)

'''
현재 토큰 가격과 네이버 부동산 시세를 비교해 평가 반환
'''
def evaluate_price(current_price, market_price):
    percent_difference = ((current_price - market_price) / market_price) * 100
    if percent_difference <= -10:
        return "매우 저평가"
    elif percent_difference <= -5:
        return "저평가"
    elif percent_difference < 5:
        return "적정가"
    elif percent_difference >= 5:
        return "고평가"
    elif percent_difference >= 10:
        return "매우 고평가"


@api.route("/building-evaluation")
class BuildingEvaluation(Resource):
    def post(self):
        try:
            # Json 데이터 Python 객체로 변환
            data = request.json
            buildingName = data.get("buildingName") # 건물명
            latitude = data.get("latitude") # 위도
            longitude = data.get("longitude") # 경도
            size = data.get("size") # 평수
            price = data.get("price") # 현재 토큰 가격
            issueVolume = data.get("volume") #발행량
            print(data)
            if buildingName == "롯데월드타워(시그니엘레지던스)":
                buildingName = "롯데월드타워앤드롯데월드몰(시그니엘레지던스)"
            # 네이버 부동산 페이지
            url = "https://m.land.naver.com/map/{}:{}:18:/APT:OPST:GM/A1".format(latitude, longitude)
            print(url)
            # 크롬 옵션 설정
            chrome_options = webdriver.ChromeOptions()
            chrome_options.add_argument("--headless")  # headless 모드

            # 크롬 드라이버 자동 설치 및 드라이버 생성
            driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)

            # 네이버 부동산 페이지 크롤링 시작
            driver.get(url)
            time.sleep(0.5)

            # 추출 대상 타겟 요소
            target = "//div[@ttl=\'{}\']".format(buildingName)
            print(target)

            # 부동산 평단가 추출
            target_div = driver.find_element(By.XPATH, target)
            print(target_div)

            # 평단가 문자 숫자 변환
            target_price = convert_currency_to_number(target_div.text)
            print(target_price)

            # 현재 토큰 가격 평가
            evaluation = evaluate_price(price * issueVolume, target_price * size)
            print("evaluation: " + evaluation)

            # JSON 형식으로 평가 결과 반환
            response_data = {
                'evaluation': evaluation,
                'reasonablePrice': (target_price * size) / issueVolume
            }

            response = json.dumps(response_data, ensure_ascii=False, indent=4)
            res = make_response(response)
            return res


        except Exception as e:
            error_response = {
                'message': 'error occurred',
                'error': str(e),
                'status': 'error'
            }
            return jsonify(error_response), 500


if __name__ == "__main__":
    app.debug = True
    app.run(debug=True, host='0.0.0.0', port=8081)