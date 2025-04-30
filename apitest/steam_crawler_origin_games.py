import json

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
    'steam_games_batch_012.json'
]


# 부모 게임 ID 추출
parent_ids = set()
all_games = []
# 기존 게임 데이터 불러오기
for j in JSON_PATH:
    with open('steam_async_batches/' + j, "r", encoding="utf-8") as f:
        all_games.append(json.load(f))
    
for games in all_games:
    for game in games:
        parent_game = game.get("parent_game")
        if parent_game:
            # 'G' 접두사를 제거하고 정수로 변환
            parent_ids.add(int(parent_game[1:]))

print(f"추출된 부모 게임 ID: {parent_ids}")

import json
import asyncio
import aiohttp
from tqdm import tqdm

# API 관련 설정
STEAM_APP_DETAILS = "https://store.steampowered.com/api/appdetails?appids={}&cc=kr&l=korean"
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
}

async def fetch_json(session, url):
    try:
        async with session.get(url, headers=HEADERS, timeout=10) as response:
            if "json" not in response.headers.get("Content-Type", "").lower():
                return None
            return await response.json()
    except Exception:
        return None

async def fetch_game_info(session, app_id):
    data = await fetch_json(session, STEAM_APP_DETAILS.format(app_id))
    if not data or not data.get(str(app_id), {}).get("success"):
        return None

    info = data[str(app_id)]["data"]

    return {
        "game_code": f"G{app_id}",
        "game_title": info.get("name"),
        "game_desc": info.get("short_description"),
        "game_contents": info.get("about_the_game"),
        "game_developer": ", ".join(info.get("developers", [])),
        "game_publisher": ", ".join(info.get("publishers", [])),
        "publishing_date": info.get("release_date", {}).get("date"),
        "game_price": info.get("price_overview", {}).get("initial", 0) // 100 if info.get("price_overview") else 0,
        "game_sale_price": info.get("price_overview", {}).get("final", 0) // 100 if info.get("price_overview") else 0,
        "discount_per": info.get("price_overview", {}).get("discount_percent", 0) if info.get("price_overview") else 0,
        "language_sup": info.get("supported_languages", ""),
        "required_age": int(info.get("required_age", 0)),
        "legal_notice": info.get("legal_notice", ""),
        "free_game": 1 if info.get("is_free") else 0,
        "website": info.get("website"),
        "game_genre": ", ".join([g["description"] for g in info.get("genres", [])]),
        "game_category": ", ".join([c["description"] for c in info.get("categories", [])]),
        "game_tag": "",
        "game_main_image": info.get("header_image"),
        "ingame_images": json.dumps([s["path_full"] for s in info.get("screenshots", [])]),
        "game_sys_req": json.dumps(info.get("pc_requirements", {}).get("minimum", "")),
        "game_sys_req_r": json.dumps(info.get("pc_requirements", {}).get("recommended", "")),
        "dlc_game": 0,
        "parent_game": None
    }

async def main():
    connector = aiohttp.TCPConnector(limit=10)
    timeout = aiohttp.ClientTimeout(total=20)
    collected = []

    async with aiohttp.ClientSession(connector=connector, timeout=timeout) as session:
        for app_id in tqdm(parent_ids, desc="📦 부모 게임 수집 중"):
            info = await fetch_game_info(session, app_id)
            if info:
                collected.append(info)
            await asyncio.sleep(1)  # 과도한 요청 방지

    with open("parent_games_steam.json", "w", encoding="utf-8") as f:
        json.dump(collected, f, ensure_ascii=False, indent=2)

    print(f"\n✅ 저장 완료: parent_games_steam.json ({len(collected)}개 게임)")

if __name__ == "__main__":
    asyncio.run(main())