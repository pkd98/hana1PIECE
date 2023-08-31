import requests
from bs4 import BeautifulSoup
import json

latitude = 37.5137519612953
longitude = 127.104446890835

url = "https://m.land.naver.com/map/{}:{}:18:/APT:OPST:GM/A1".format(latitude, longitude)
res = requests.get(url)
res.raise_for_status()
soup = BeautifulSoup(res.text, "lxml")
html_string = soup.prettify()

print(html_string)