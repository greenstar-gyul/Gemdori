import asyncio
import aiohttp
import json
import time
from tqdm import tqdm

OUTPUT_FILE = "all_games_steam_2.json"
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
}
STEAM_APP_DETAILS = "https://store.steampowered.com/api/appdetails?appids={}&cc=kr&l=korean"

# 인기 AppID 50개 수동 세팅 (중복 없이 인기 있는 게임들)
TOP_50_APP_IDS = [
    730, 570, 440, 578080, 271590, 1172470, 1085660, 359550, 252490, 381210,
    1091500, 304930, 346110, 739630, 4000, 275850, 413150, 236390, 238960, 945360,
    105600, 292030, 289070, 1222670, 1506830, 306130, 108600, 359320, 230410, 493340,
    8930, 9430, 312520, 431960, 552500, 49520, 222880, 431240, 1057090, 204360,
    1940340, 438100, 1063730, 1229490, 39210, 1260320, 1328670, 275390, 814380, 306130
]

TOP_150_APP_IDS = [
    # 기존 50개 AppID
    730, 570, 440, 578080, 271590, 1172470, 1085660, 359550, 252490, 381210,
    1091500, 304930, 346110, 739630, 4000, 275850, 413150, 236390, 238960, 945360,
    105600, 292030, 289070, 1222670, 1506830, 306130, 108600, 359320, 230410, 493340,
    8930, 9430, 312520, 431960, 552500, 49520, 222880, 431240, 1057090, 204360,
    1940340, 438100, 1063730, 1229490, 39210, 1260320, 1328670, 275390, 814380, 306130,
    # 추가 100개 AppID
    578080, 271590, 1172470, 1085660, 359550, 252490, 381210, 1091500, 304930, 346110,
    739630, 4000, 275850, 413150, 236390, 238960, 945360, 105600, 292030, 289070,
    1222670, 1506830, 306130, 108600, 359320, 230410, 493340, 8930, 9430, 312520,
    431960, 552500, 49520, 222880, 431240, 1057090, 204360, 1940340, 438100, 1063730,
    1229490, 39210, 1260320, 1328670, 275390, 814380, 306130, 730, 570, 440,
    578080, 271590, 1172470, 1085660, 359550, 252490, 381210, 1091500, 304930, 346110,
    739630, 4000, 275850, 413150, 236390, 238960, 945360, 105600, 292030, 289070,
    1222670, 1506830, 306130, 108600, 359320, 230410, 493340, 8930, 9430, 312520,
    431960, 552500, 49520, 222880, 431240, 1057090, 204360, 1940340, 438100, 1063730,
    1229490, 39210, 1260320, 1328670, 275390, 814380, 306130, 730, 570, 440,
    578080, 271590, 1172470, 1085660, 359550, 252490, 381210, 1091500, 304930, 346110,
    739630, 4000, 275850, 413150, 236390, 238960, 945360, 105600, 292030, 289070,
    1222670, 1506830, 306130, 108600, 359320, 230410, 493340, 8930, 9430, 312520,
    431960, 552500, 49520, 222880, 431240, 1057090, 204360, 1940340, 438100, 1063730
]

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
    is_dlc = 1 if "fullgame" in info and info["fullgame"] else 0
    parent_game = str(info["fullgame"]["appid"]) if is_dlc else None

    if info.get("is_free"):
        price = sale_price = discount = 0
    elif "price_overview" in info:
        price = info["price_overview"]["initial"] // 100
        sale_price = info["price_overview"]["final"] // 100
        discount = info["price_overview"]["discount_percent"]
    else:
        price = sale_price = discount = None

    # pc_requirements 처리 (리스트와 딕셔너리 구분)
    pc_requirements = info.get("pc_requirements", {})
    if isinstance(pc_requirements, dict):
        minimum = pc_requirements.get("minimum", "")
        recommended = pc_requirements.get("recommended", "")
    elif isinstance(pc_requirements, list) and pc_requirements:
        minimum = pc_requirements[0].get("minimum", "")
        recommended = pc_requirements[0].get("recommended", "")
    else:
        minimum = recommended = ""

    return {
        "game_code": f"G{app_id}",
        "game_title": info.get("name"),
        "game_desc": info.get("short_description"),
        "game_contents": info.get("about_the_game"),
        "game_developer": ", ".join(info.get("developers", [])),
        "game_publisher": ", ".join(info.get("publishers", [])),
        "publishing_date": info.get("release_date", {}).get("date"),
        "game_price": price,
        "game_sale_price": sale_price,
        "discount_per": discount,
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
        "game_sys_req": json.dumps(minimum),
        "game_sys_req_r": json.dumps(recommended),
        "dlc_game": is_dlc,
        "parent_game": f"G{parent_game}" if parent_game else None
    }


async def fetch_dlc_ids(session, app_id):
    data = await fetch_json(session, STEAM_APP_DETAILS.format(app_id))
    if not data or not data.get(str(app_id), {}).get("success"):
        return []
    return data[str(app_id)]["data"].get("dlc", [])

async def main():
    connector = aiohttp.TCPConnector(limit=10)
    timeout = aiohttp.ClientTimeout(total=20)

    collected = {}
    async with aiohttp.ClientSession(connector=connector, timeout=timeout) as session:
        for app_id in tqdm(TOP_150_APP_IDS, desc="📥 인기 게임 수집 중"):
            if app_id in collected:
                continue
            info = await fetch_game_info(session, app_id)
            if not info:
                continue
            collected[app_id] = info

            # DLC라면 → 부모 게임 가져오기
            if info["dlc_game"] and info["parent_game"]:
                parent_id = int(info["parent_game"][1:])
                if parent_id not in collected:
                    parent_info = await fetch_game_info(session, parent_id)
                    if parent_info:
                        collected[parent_id] = parent_info

            # DLC 목록 가져오기
            dlc_ids = await fetch_dlc_ids(session, app_id)
            for dlc_id in dlc_ids:
                if dlc_id not in collected:
                    dlc_info = await fetch_game_info(session, str(dlc_id))
                    if dlc_info:
                        collected[dlc_id] = dlc_info
                        # DLC의 부모 게임도 안전하게 한 번 더
                        if dlc_info["parent_game"]:
                            p_id = int(dlc_info["parent_game"][1:])
                            if p_id not in collected:
                                parent_info = await fetch_game_info(session, p_id)
                                if parent_info:
                                    collected[p_id] = parent_info
                await asyncio.sleep(1)  # 과도한 요청 방지

    # 저장
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        json.dump(list(collected.values()), f, ensure_ascii=False, indent=2)

    print(f"\n✅ 저장 완료: {OUTPUT_FILE} ({len(collected)}개 게임)")

if __name__ == "__main__":
    asyncio.run(main())
