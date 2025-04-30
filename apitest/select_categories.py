import cx_Oracle
import json

import re

# 1. DB 연결
dsn = cx_Oracle.makedsn("localhost", 1521, service_name="xe")
conn = cx_Oracle.connect(user="scott", password="tiger", dsn=dsn, encoding="UTF-8")
cursor = conn.cursor()

# 3. 삽입
select_sql = """
SELECT game_genre FROM gemdori_game_tbl
"""

result = cursor.execute(select_sql)

genres = []
origin_genres = set()

for r in result:
    for e in r:
        if e:
            genres.append(e)

for genre in genres:
    split_genres = [g.strip() for g in genre.split(",")]
    origin_genres.update(split_genres)

print(origin_genres)

select_sql = """
SELECT game_category FROM gemdori_game_tbl
"""

result = cursor.execute(select_sql)

categories = []
origin_categories = set()

for r in result:
    for e in r:
        if e:
            categories.append(e)

for category in categories:
    split_categories = [c.strip() for c in category.split(",")]
    origin_categories.update(split_categories)

print(origin_categories)

cursor.close()
conn.close()