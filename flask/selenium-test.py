import time

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By

# 문자 변환
def convert_currency_to_number(currency_str):
    if '만원' in currency_str:
        number = float(currency_str.replace('만원', '').replace(',', '')) * 10000
    elif '억' in currency_str:
        number = float(currency_str.replace('억', '').replace(',', '')) * 100000000
    else:
        number = float(currency_str.replace(',', ''))
    return int(number)


# 위도, 경도, 부동산명
latitude = 37.5137519612953
longitude = 127.104446890835
building_name = "롯데월드타워앤드롯데월드몰(시그니엘레지던스)"
target = "//div[@ttl=\'{}\']".format(building_name)

# 네이버 부동산 페이지
url = "https://m.land.naver.com/map/{}:{}:18:/APT:OPST:GM/A1".format(latitude, longitude)

# 크롬 옵션 설정
chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument("--headless")  # headless 모드

# 크롬 드라이버 자동 설치 및 드라이버 생성
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)

# 네이버 부동산 페이지 크롤링 시작
driver.get(url)
time.sleep(0.5)

# ttl 속성 값: 원하는 부동산 이름의 div 요소의 데이터 가져옴. (부동산 평단 가격)
target_div = driver.find_element(By.XPATH, target)

price = convert_currency_to_number(target_div.text)


# 찾은 요소 출력
print(price)

# 크롬 드라이버 종료
driver.quit()
