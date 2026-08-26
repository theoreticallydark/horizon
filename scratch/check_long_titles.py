import json

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']
long_titles = [f for f in foods if len(f.get('title', '')) > 24]

print(f"Total foods: {len(foods)}, Over 24 chars: {len(long_titles)}")
for f in long_titles[:25]:
    print(f"[{len(f['title'])}]: {f['title']}")
