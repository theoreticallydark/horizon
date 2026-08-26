import json
import re

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']

def clean_usda_name(name, category):
    # Strip USDA program notes
    name = re.sub(r'\(Includes foods for USDA.*?\)', '', name, flags=re.IGNORECASE)
    name = re.sub(r'\(include.*?\)', '', name, flags=re.IGNORECASE)
    name = re.sub(r'\(approx.*?\)', '', name, flags=re.IGNORECASE)
    name = re.sub(r'\(formerly.*?\)', '', name, flags=re.IGNORECASE)
    name = re.sub(r'\(dry.*?\)', '', name, flags=re.IGNORECASE)
    
    parts = [p.strip() for p in name.split(',') if p.strip()]
    return parts

samples = []
for f in foods[:50]:
    samples.append((f.get('food_id'), f.get('name'), f.get('title'), clean_usda_name(f.get('name'), f.get('category'))))

with open('scratch/sample_cleaned.txt', 'w', encoding='utf-8') as out:
    for sid, name, title, parts in samples:
        out.write(f"ID: {sid}\nORIGINAL NAME: {name}\nCURRENT TITLE: {title}\nPARTS: {parts}\n---\n")

print("Saved sample to scratch/sample_cleaned.txt")
