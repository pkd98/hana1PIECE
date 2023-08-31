from flask import Flask
import requests
from bs4 import BeautifulSoup
import json

'''
[네이버 부동산 크롤링]
    대상 페이지) https://m.land.naver.com/map/{위도}:{경도}:18:/APT:OPST:GM/A1
    
    - 위도:경도:18:/APT:OPST:GM -> 해당 범위 크롤링 -> 해당 건물 데이터 추출

예시)
<div class="COMPLEX_container markerContainer" style="margin: 0px; padding: 0px; border: 0px currentcolor; left: 0px; top: 0px; width: 100%; height: 5px; overflow: visible; position: absolute; z-index: 110; display: block;" _key="COMPLEX"><div class="pin is-active _marker _markerEnv" style="transform: translate3d(-50%, 0px, 0px); left: 271.015px; top: 671.474px;" ttl="롯데월드타워앤드롯데월드몰(시그니엘레지던스)" poitype="CC" key="118602" lat="37.5125" lon="127.102611" count="1" lgeo="21221110033002">   <i class="pin_icon sp_icon ico_complex _markerEnv"></i><span class="pin_year _markerEnv">5,594만원</span></div><div class="pin is-active _marker _markerEnv" style="transform: translate3d(-50%, 0px, 0px); left: 212.481px; top: 165.728px;" ttl="잠실시그마타워(주상복합)" poitype="CC" key="8972" lat="37.514652" lon="127.102297" count="1" lgeo="21221110033220">   <i class="pin_icon sp_icon ico_complex _markerEnv"></i><span class="pin_year _markerEnv">4,343만원</span></div><div class="pin is-active _marker _markerEnv" style="transform: translate3d(-50%, 0px, 0px); left: 236.715px; top: 51.0407px;" ttl="현대타워(주상복합)" poitype="CC" key="3753" lat="37.51514" lon="127.102427" count="1" lgeo="21221110033222">   <i class="pin_icon sp_icon ico_complex _markerEnv"></i><span class="pin_year _markerEnv">3,593만원</span></div><div class="pin is-active _marker _markerEnv" style="transform: translate3d(-50%, 0px, 0px); left: 1249.22px; top: 957.007px;" poitype="CC" key="21221110120232" lat="37.511285" lon="127.1078585" count="2" lgeo="21221110120232">   <i class="pin_icon sp_icon ico_complex _markerEnv"></i><span class="pin_count _markerEnv">2</span></div><div class="pin is-active _marker _markerEnv" style="transform: translate3d(-50%, 0px, 0px); left: 1157.04px; top: 150.217px;" ttl="잠실리시온" poitype="CC" key="12589" lat="37.514718" lon="127.107364" count="1" lgeo="21221110122221">   <i class="pin_icon sp_icon ico_complex _markerEnv"></i><span class="pin_year _markerEnv">1,570만원</span></div><div class="pin is-active _marker _markerEnv" style="transform: translate3d(-50%, 0px, 0px); left: 1168.22px; top: -10.7688px;" ttl="대우유토피아" poitype="CC" key="12381" lat="37.515403" lon="127.107424" count="1" lgeo="21221110122223">   <i class="pin_icon sp_icon ico_complex _markerEnv"></i><span class="pin_year _markerEnv">1,157만원</span></div></div>

    ttl="건물명" -> <span class="pin_year _markerEnv">5,594만원</span> 금액 찾기
    5594 추출 -> 평당 55940000 * 입력 평수 => 현재 토큰가격 비교 평가
'''

'''
[Rest API]
get 요청: 건물명, 위도, 경도, 평수, 현재 토큰 가격 (스프링 스케줄러 요청)
문자열 평가 반환: 매우 저평가(-10%), 저평가(-5%), 적정가, 고평가(+5%), 매우 고평가(+10%)
'''

latitude = 37.5137519612953
longitude = 127.104446890835

url = "https://m.land.naver.com/map/{}:{}:18:/APT:OPST:GM/A1".format(latitude, longitude)
res = requests.get(url)
res.raise_for_status()
soup = (str)(BeautifulSoup(res.text, "lxml"))

print(soup)

# app = Flask(__name__)
#
# @app.route('/')
# def hello_world():  # put application's code here
#     return 'Hello World!'
#
#
# if __name__ == '__main__':
#     app.run()
