import json

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']
print(f"Total foods: {len(foods)}")

with open('scratch/all_titles.txt', 'w', encoding='utf-8') as out:
    for i, food in enumerate(foods):
        out.write(f"{food.get('id')}\t{food.get('title')}\n")

print("Saved all titles to scratch/all_titles.txt")
