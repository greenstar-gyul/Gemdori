import json
import random
import cx_Oracle

from datetime import datetime, timedelta

def get_random_date_within_last_3_years():
    today = datetime.today()
    days_back = 365 * 3
    random_days = random.randint(0, days_back)
    random_date = today - timedelta(days=random_days)
    return random_date.strftime("%Y-%m-%d")  # 또는 "%Y년 %-m월 %-d일"

def get_random_date_within_last_40_years():
    today = datetime.today()
    days_back = 365 * 40
    random_days = random.randint(0, days_back)
    random_date = today - timedelta(days=random_days)
    return random_date.strftime("%Y-%m-%d")  # 또는 "%Y년 %-m월 %-d일"

gender = [ 'M', 'F' ]

# 리뷰 데이터 생성
def generate_users():
    user_sign_list = []
    user_profile_list = []
    user_sequrity_list = []
    
    for i in range(500):
        user_code = f'U{i + 7}'
        
        user_sign = {
            'user_code': user_code,
            "user_id": f'tester{i + 1}',
            'user_pw': 'q12345678',
            'create_time': get_random_date_within_last_3_years()
        }
        user_sign_list.append(user_sign)
        
        user_profile = {
            "user_code": f'{user_code}',
            'user_first_name': f'tes{i}',
            'user_last_name': 'ter',
            'user_name': f'testuser{i}',
            'user_email': f'abc@def.com',
            'user_phone': f'010-1234-5678',
            'user_birthday': get_random_date_within_last_40_years(),
            'user_gender': gender[random.randint(0, 1)]
        }
        user_profile_list.append(user_profile)
        
        user_sequrity = {
            'user_code': user_code,
            'login_fail_count': 0,
            'is_locked': 1
        }
        user_sequrity_list.append(user_sequrity)
    
    return user_sign_list, user_profile_list, user_sequrity_list

user_sign_list, user_profile_list, user_sequrity_list = generate_users()

dsn = cx_Oracle.makedsn("localhost", 1521, service_name="xe")
conn = cx_Oracle.connect(user="scott", password="tiger", dsn=dsn, encoding="UTF-8")
cursor = conn.cursor()

# 3. 삽입
insert_sign = """
    insert into gemdori_user_sign_tbl(
    user_code,
    user_id,
    user_pw,
    user_status,
    create_time)
    values(
    :user_code,
    :user_id,
    :user_pw,
    1,
    :create_time)
"""

insert_profile = """
    insert into gemdori_user_profile_tbl(
    user_code,
    user_first_name,
    user_last_name,
    user_name,
    user_email,
    user_phone,
    user_birthday,
    user_gender)
    values(
    :user_code,
    :user_first_name,
    :user_last_name,
    :user_name,
    :user_email,
    :user_phone,
    :user_birthday,
    :user_gender)
"""

insert_sequrity = """
    insert into gemdori_user_security_tbl (
        user_code,
        login_fail_count,
        is_locked
    ) values (
        :user_code,
        :login_fail_count,
        :is_locked
    )
"""

for user in user_sign_list:
    try:
        cursor.execute(insert_sign, user)
        print(f"✅ 삽입 성공: {user['user_id']}")
    except Exception as e:
        print(f"❌ 삽입 실패: {user['user_id']} - {e}")

for user in user_profile_list:
    try:
        cursor.execute(insert_profile, user)
        print(f"✅ 삽입 성공: {user['user_name']}")
    except Exception as e:
        print(f"❌ 삽입 실패: {user['user_name']} - {e}")

for user in user_sequrity_list:
    try:
        cursor.execute(insert_sequrity, user)
        print(f"✅ 삽입 성공: {user['user_code']}")
    except Exception as e:
        print(f"❌ 삽입 실패: {user['user_code']} - {e}")

conn.commit()
cursor.close()
conn.close()


# with open('game_code.json', 'r', encoding='utf-8') as f:
#     all_game_codes.append(json.load(f))
    
# json_game_codes = all_game_codes[0].get('results')[0].get('items')

# common_game_codes = [
    
# ]

# for game_code in json_game_codes:
#     code = game_code['game_code']
#     if code not in popular_game_codes:
#         common_game_codes.append(code)
        
# # print(common_game_codes)
# common = generate_reviews(common_game_codes, False)

# popular = generate_reviews(popular_game_codes, True)

# with open('common_review_list.json', 'w', encoding='utf-8') as f:
#     json.dump(common, f, ensure_ascii=False, indent=2)

# with open('popular_review_list.json', 'w', encoding='utf-8') as f:
#     json.dump(popular, f, ensure_ascii=False, indent=2)

# sample_review = []  
# with open('popular_game_reviews_top20.json', 'r', encoding='utf-8') as f:
#     sample_review = json.load(f)
    
# print(sample_review)