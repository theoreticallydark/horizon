import json
import re

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']

from constrain_titles_24 import constrain_title_to_24

for f in foods:
    t = f.get('title', '')
    name = f.get('name', '')
    cat = f.get('category', '')
    new_t = constrain_title_to_24(t, name, cat)
    f['title'] = new_t

with open('sources/dri_and_foods.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print("Saved updated sources/dri_and_foods.json with <= 24 char title constraints.")
