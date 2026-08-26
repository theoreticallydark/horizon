import json

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Update vitamin_b12 key in all demographics in data list
dri_data = data['sources']['dri']['data']
count = 0
for entry in dri_data:
    nutrients = entry.get('nutrients', {})
    if 'vitamin_b12' in nutrients:
        nutrients['vitamin_b12']['key'] = 'V B12'
        count += 1

print(f"Updated vitamin_b12 key to 'V B12' across {count} demographic entries.")

with open('sources/dri_and_foods.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print("Saved updated sources/dri_and_foods.json successfully.")
