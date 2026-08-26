import json

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']

# Patterns to inspect:
# 1. Ending in numbers e.g. "Cereals ready 74654", "Egg 29490"
# 2. Incomplete phrases e.g. "pineapple and", "Milk with", "Cheese without"
# 3. All lowercase or uncapitalized e.g. "wheat", "white wheat"
# 4. Truncated words e.g. "Rice white lon 68878", "Flour wheat al 89951"
# 5. Inverted commas e.g. "Pasta, whole wheat" -> "Pasta whole wheat"

suspicious = []
for f in foods:
    t = f.get('title', '')
    name = f.get('name', '')
    fid = f.get('food_id', '')
    cat = f.get('category', '')
    
    # check indicators of poor titles
    words = t.split()
    has_digit = any(char.isdigit() for char in t)
    is_lower = t[0].islower() if t else False
    is_incomplete = any(t.lower().endswith(w) for w in [' and', ' with', ' without', ' for', ' of', ' or', ' in', ' al', ' lon', ' low', ' fat', ' ready', ' shelf', ' plain', ' includes'])
    is_short_or_awkward = len(words) == 1 and t in ['Cheese', 'Egg', 'Milk', 'Yogurt', 'Orange', 'Oats', 'Barley', 'Millet', 'wheat', 'Garlic', 'Onion', 'Peanuts']
    
    suspicious.append({
        'id': fid,
        'name': name,
        'title': t,
        'cat': cat,
        'has_digit': has_digit,
        'is_lower': is_lower,
        'is_incomplete': is_incomplete
    })

print(f"Total foods: {len(foods)}")
print(f"With digits in title: {sum(1 for s in suspicious if s['has_digit'])}")
print(f"Starting lowercase: {sum(1 for s in suspicious if s['is_lower'])}")
print(f"Ending in hanging word: {sum(1 for s in suspicious if s['is_incomplete'])}")
