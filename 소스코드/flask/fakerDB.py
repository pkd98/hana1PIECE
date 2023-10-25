import random
import uuid
import string
from faker import Faker
import oracledb
import os
import environ

# oracle wallet 설정 파일
current_dir = os.path.dirname(os.path.abspath(__file__))
env_file_path = os.path.join(current_dir, "DBconfig.env")

insert_member_query = """
    INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
    VALUES (:1, :2, :3, :4, :5, :6)
"""

insert_account_query = """
    INSERT INTO ACCOUNT (ACCOUNT_NUMBER, PASSWORD, BALANCE, OPENING_DATE, RESIDENT_NUMBER1, RESIDENT_NUMBER2, NAME)
    VALUES (:1, :2, :3, TO_DATE(:4, 'YYYY-MM-DD'), :5, :6, :7)
"""

insert_wallet_query = """
    INSERT INTO WALLET (WALLET_NUMBER, MEMBER_ID, ACCOUNT_NUMBER, PASSWORD, BALANCE)
    VALUES (:1, :2, :3, :4, :5)
"""

insert_stos_query = """
    INSERT INTO STOS (WALLET_NUMBER, LISTING_NUMBER, AMOUNT)
    VALUES (:1, :2, :3)
"""


member_data = []
account_data = []
wallet_data = []
stos_data = []

def getEnvConfig():
    config = {}
    try:
        environ.Env.read_env(env_file_path)
    except:
        raise Exception("ENV FILE NOT FOUND")
    try:
        config['user'] = os.environ.get('user')
        config['password'] = os.environ.get('password')
        config['dsn'] = os.environ.get('dsn')
        config['config_dir'] = os.environ.get('config_dir')
        config['wallet_location'] = os.environ.get('wallet_location')
        config['wallet_password'] = os.environ.get('wallet_password')
    except:
        raise Exception("ENV NOT AVAILABLE")
    return config

# 커넥션 맺기
def create_connection():
    config = getEnvConfig()

    connection = oracledb.connect(
        user=config['user'],
        password=config['password'],
        dsn=config['dsn'],
        config_dir=config['config_dir'],
        wallet_location=config['wallet_location'],
        wallet_password=config['wallet_password']
    )
    return connection

connection = create_connection()
cursor = connection.cursor()  # 루프 바깥에서 커서 생성

# Faker 객체 생성
fake = Faker()


def generate_korean_rrn():
    # Generate the birth date
    birth_date = fake.date_of_birth(minimum_age=20, maximum_age=50)
    year = birth_date.strftime('%y')
    month = birth_date.strftime('%m')
    day = birth_date.strftime('%d')

    # Generate the gender identifier, 1 or 2 (for those born between 1900 and 1999)
    gender = random.choice(['1', '2'])

    # Generate a 4-digit random number
    random_numbers = '{:04}'.format(random.randint(1, 9999))

    return year + month + day + gender + random_numbers


def generate_referral_code():
    characters = string.ascii_uppercase + string.digits  # A-Z and 0-9
    referral_code = ''.join(random.choice(characters) for _ in range(5))
    return referral_code

def is_duplicate(table, column, value):
    cursor.execute(f"SELECT COUNT(*) FROM {table} WHERE {column} = :1", [value])
    count = cursor.fetchone()[0]
    return count > 0


def regenerate_member_id():
    while True:
        length = random.randint(6, 15)
        member_id = str(uuid.uuid4())[:length]

        # 이미 member_data 리스트 안에 있는지 검사
        if any(data[0] == member_id for data in member_data):
            continue

        # DB에 이미 있는지 검사
        if is_duplicate('ONE_MEMBERS', 'ID', member_id):
            continue

        return member_id



count = 0
# 더미 데이터 생성
for _ in range(50000):
    # ONE_MEMBERS 테이블에 더미 데이터 삽입
    length = random.randint(6, 15)
    member_id = regenerate_member_id()
    name = 'test'  # 회원 이름
    password = 'test123'  # 비밀번호
    phone = '01012341234'  # 휴대전화
    email = 'test@test.com'  # 이메일
    referral_code = generate_referral_code()  # Generates a 5-character long referral code

    # ACCOUNT 테이블에 더미 데이터 생성
    account_password = fake.password(length=4, special_chars=False, digits=True, upper_case=False,
                                     lower_case=False)  # 계좌 비밀번호
    account_balance = 1000000  # 잔액 (100만원)
    opening_date = fake.date_this_decade()  # 계좌 개설일
    resident_number = generate_korean_rrn()
    split_resident_number = resident_number.split("-")
    resident_number1 = resident_number[:6]  # 주민등록번호 앞자리
    resident_number2 = resident_number[6:]  # 주민등록번호 뒷자리
    account_name = fake.name()[:20]  # Truncate name to 20 characters

    # WALLET 테이블에 더미 데이터 삽입
    wallet_number = fake.random_int(min=5000, max=999999999999999999)  # 지갑번호
    account_number = fake.random_int(min=1000000000, max=999999999999999)  # 연동 계좌번호
    wallet_password = 1234  # 지갑 비밀번호
    balance = 1000000  # 잔액 (100만원)

    # STOS 테이블에 더미 데이터 삽입
    listing_number = 26  # 매물번호 (고정값)
    amount = 10  # 보유수량 (10개씩)

    member_data.append((member_id, name, password, phone, email, referral_code))
    account_data.append((account_number, account_password, account_balance, opening_date, resident_number1, resident_number2, account_name))
    wallet_data.append((wallet_number, member_id, account_number, wallet_password, balance))
    stos_data.append((wallet_number, listing_number, amount))

    count += 1

    if(count % 1000 == 0):
        # 일괄 처리로 데이터 삽입
        cursor.executemany(insert_member_query, member_data)
        cursor.executemany(insert_account_query, account_data)
        cursor.executemany(insert_wallet_query, wallet_data)
        cursor.executemany(insert_stos_query, stos_data)

        connection.commit()  # 한 번만 커밋
        print(f"Processed: {count} records")

        # 리스트 초기화
        member_data.clear()
        account_data.clear()
        wallet_data.clear()
        stos_data.clear()



cursor.close()
connection.close()
