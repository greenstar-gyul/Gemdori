from datetime import datetime, timedelta
import json
import random

# 리뷰 평점 매핑
def mapping_rating(rating):
    if rating == 'bad':
        return random.randint(0, 2)
    elif rating == 'low':
        return random.randint(3, 5)
    elif rating == 'mid':
        return random.randint(5, 7)
    elif rating == 'high':
        return random.randint(8, 9)
    elif rating == 'excellent':
        return random.randint(9, 10)
    else:
        return 0
    
def get_random_date_within_last_2_years():
    today = datetime.today()
    days_back = 365 * 2
    random_days = random.randint(0, days_back)
    random_date = today - timedelta(days=random_days)
    return random_date.strftime("%Y-%m-%d")  # 또는 "%Y년 %-m월 %-d일"

# 리뷰 데이터 생성
def generate_reviews(game_codes, is_popular=False):
    reviews = []
    
    sample_review = []
    if (is_popular):
        with open('popular_game_reviews_top20.json', 'r', encoding='utf-8') as f:
            sample_review = json.load(f)
    else:
        with open('sample_reviews.json', 'r', encoding='utf-8') as f:
            sample_review = json.load(f)
    # print(sample_review)
    reviews = []
    
    for game_code in game_codes:
        review_count = random.randint(18, 25) if is_popular else random.randint(5, 10)
        user_list = random.sample(range(7, 507), review_count)
        
        for i in range(review_count):
            idx = random.randint(0, len(sample_review) - 1)
            review = {
                "game_code": game_code,
                "review_contents": sample_review[idx]['review'],
                "rating": mapping_rating(sample_review[idx]['rating']) / 2,
                "user_code": f'U{user_list[i]}',
                "write_date": get_random_date_within_last_2_years()
            }
            reviews.append(review)
    return reviews

# # 인기 게임에 대한 리뷰 생성
# popular_reviews = generate_reviews(popular_game_codes, is_popular=True)
# # 나머지 게임에 대한 리뷰 생성
# other_reviews = generate_reviews(all_game_codes, is_popular=False)

# # 결과를 합침
# all_reviews = popular_reviews + other_reviews

# # JSON 형식으로 저장
# json_output = json.dumps(all_reviews, indent=4)

popular_game_codes = [
    "G730", "G570", "G440", "G578080", "G271590", "G1172470", "G1085660", "G359550", "G252490", 
    "G381210", "G1091500", "G304930", "G346110", "G739630", "G4000", "G275850", "G413150", 
    "G236390", "G238960", "G945360", "G105600", "G292030", "G289070", "G1222670", "G1506830", 
    "G306130", "G108600", "G359320", "G230410", "G493340", "G8930", "G9430", "G312520", "G431960", 
    "G552500", "G49520", "G222880", "G431240", "G1057090", "G204360", "G1940340", "G438100", "G1063730", 
    "G1229490", "G39210", "G1260320", "G1328670", "G275390", "G814380", "G306130"
]

all_game_codes = [
    
]

with open('game_codes.json', 'r', encoding='utf-8') as f:
    all_game_codes.append(json.load(f))
    
json_game_codes = all_game_codes[0].get('results')[0].get('items')

common_game_codes = [
    
]

for game_code in json_game_codes:
    code = game_code['game_code']
    if code not in popular_game_codes:
        common_game_codes.append(code)

# print(len(common_game_codes))

common = generate_reviews(common_game_codes, False)

popular = generate_reviews(popular_game_codes, True)

with open('gen_review/common_review_list.json', 'w', encoding='utf-8') as f:
    json.dump(common, f, ensure_ascii=False, indent=2)

with open('gen_review/popular_review_list.json', 'w', encoding='utf-8') as f:
    json.dump(popular, f, ensure_ascii=False, indent=2)

# sample_review = []  
# with open('popular_game_reviews_top20.json', 'r', encoding='utf-8') as f:
#     sample_review = json.load(f)
    
# print(sample_review)