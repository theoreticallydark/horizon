import json

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']
print("First food object keys and sample:")
first = foods[0]
for k, v in first.items():
    if k != 'nutrients':
        print(f"  {k}: {v}")
    else:
        print(f"  nutrients: [{len(v)} nutrients]")
