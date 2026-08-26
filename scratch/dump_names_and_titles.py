import json

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']

with open('scratch/food_names_and_titles.txt', 'w', encoding='utf-8') as out:
    for f in foods:
        out.write(f"ID: {f.get('food_id')}\nNAME: {f.get('name')}\nTITLE: {f.get('title')}\nCATEGORY: {f.get('category')}\n---\n")

print(f"Dumped {len(foods)} foods to scratch/food_names_and_titles.txt")
