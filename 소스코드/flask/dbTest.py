import oracledb
import os
import environ

current_dir = os.path.dirname(os.path.abspath(__file__))
env_file_path = os.path.join(current_dir, "DBconfig.env")


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
cursor = connection.cursor()
cursor.execute("""
    select * from stos
""")
data = cursor.fetchall()
print(data)