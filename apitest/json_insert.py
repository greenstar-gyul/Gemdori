import re
import cx_Oracle
import json

from datetime import datetime

JSON_PATH = [
    'steam_games_batch_001.json',
    'steam_games_batch_002.json',
    'steam_games_batch_003.json',
    'steam_games_batch_004.json',
    'steam_games_batch_005.json',
    'steam_games_batch_006.json',
    'steam_games_batch_007.json',
    'steam_games_batch_008.json',
    'steam_games_batch_009.json',
    'steam_games_batch_010.json',
    'steam_games_batch_011.json',
    'steam_games_batch_012.json',
    'parent_games_steam.json'
]

# 1. DB 연결
dsn = cx_Oracle.makedsn("localhost", 1521, service_name="xe")
conn = cx_Oracle.connect(user="scott", password="tiger", dsn=dsn, encoding="UTF-8")
cursor = conn.cursor()

# 2. JSON 데이터 로드
games_list = []
for j in JSON_PATH:
    with open(f"steam_async_batches/{j}", "r", encoding="utf-8") as f:
        games = json.load(f)
        games_list.append(games)

# 3. 삽입
insert_sql = """
INSERT INTO gemdori_game_tbl (
    game_code, game_title, game_desc, 
    game_developer, game_publisher, publishing_date,
    game_price, game_sale_price, discount_per,
    language_sup, required_age, legal_notice, free_game, website,
    game_genre, game_category, game_tag, game_main_image,
    game_sys_req, game_sys_req_r,
    dlc_game, parent_game, game_contents, desc_images
) VALUES (
    :game_code, :game_title, :game_desc,
    :game_developer, :game_publisher, TO_DATE(:publishing_date, 'yyyy-MM-dd'),
    NVL(:game_price, 0), :game_sale_price, :discount_per,
    :language_sup, :required_age, :legal_notice, :free_game, :website,
    :game_genre, :game_category, :game_tag, :game_main_image,
    :game_sys_req, :game_sys_req_r,
    :dlc_game, :parent_game, :game_contents, :ingame_images
)
"""

# 4. 연/월/일 데이터 전처리
def clean_release_date(raw_date):
    if not raw_date:
        return None

    raw_date = str(raw_date).strip()
    if "예정" in raw_date or raw_date.lower() in ["tba", ""]:
        return None

    try:
        # 전체: 2024년 4월 16일
        match = re.search(r"(\d{4})\s*년\s*(\d{1,2})\s*월\s*(\d{1,2})\s*일", raw_date)
        if match:
            return f"{match.group(1)}-{int(match.group(2)):02}-{int(match.group(3)):02}"

        # 연/월: 2024년 4월
        match = re.search(r"(\d{4})\s*년\s*(\d{1,2})\s*월", raw_date)
        if match:
            return f"{match.group(1)}-{int(match.group(2)):02}-01"

        # 연도만: 2023년
        match = re.search(r"(\d{4})\s*년", raw_date)
        if match:
            return f"{match.group(1)}-01-01"
    except Exception as e:
        print(f"❌ 정제 실패: {raw_date!r} - {e}")
        return None

    return None

# 4. 데이터 삽입
for games in games_list:
    for game in games:
        try:
            raw = game.get('publishing_date') or ''
            # print(f"원본 날짜: {game['publishing_date']!r}")
            game['publishing_date'] = clean_release_date(raw)
            # print(game['publishing_date'])
            cursor.execute(insert_sql, game)
            print(f"✅ 삽입 성공: {game['game_code']}")
        except Exception as e:
            print(f"❌ 삽입 실패: {game['game_code']} - {e}")

conn.commit()
cursor.close()
conn.close()
