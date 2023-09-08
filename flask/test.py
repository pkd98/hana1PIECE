import requests
import uuid
import time
import json

api_url = 'https://muegq3pk2d.apigw.ntruss.com/custom/v1/24870/75f0c26ee0de4c3b5a24de0428c076ddaa5ff4d12df4650be5aa97522bfd277a/infer'
secret_key = 'Um9MeW1rc0xzamxGSmpza3hGdFVYR2p1RlZ0eEpDSW8='

image_file = '/Users/pkd/Desktop/신분증.png'
output_file = '/Users/pkd/Desktop/output.json'

templateId=26296

request_json = {
    'images': [
        {
            'format': 'png',
            'name': 'demo',
            'templateIds': [templateId]
        }
    ],
    'requestId': str(uuid.uuid4()),
    'version': 'V2',
    'timestamp': int(round(time.time() * 1000))
}

payload = {'message': json.dumps(request_json).encode('UTF-8')}
files = [
  ('file', open(image_file,'rb'))
]
headers = {
  'X-OCR-SECRET': secret_key
}

response = requests.request("POST", api_url, headers=headers, data = payload, files = files)

res = json.loads(response.text.encode('utf8'))
print(res)

with open(output_file, 'w', encoding='utf-8') as outfile:
    json.dump(res, outfile, indent=4, ensure_ascii=False)