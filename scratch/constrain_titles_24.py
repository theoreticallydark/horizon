import json
import re

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']

def constrain_title_to_24(title, name, cat):
    if len(title) <= 24:
        return title
    
    # 1. If it has parentheses, try removing or simplifying parenthetical info
    if '(' in title and ')' in title:
        # Check title without parentheses
        base = re.sub(r'\(.*?\)', '', title).strip()
        base = re.sub(r'\s+', ' ', base)
        if len(base) <= 24 and len(base) >= 4:
            # Maybe keep a short modifier if it fits
            match = re.search(r'\((.*?)\)', title)
            if match:
                inner = match.group(1).split(',')[0].strip()
                combined = f"{base} ({inner})"
                if len(combined) <= 24:
                    return combined
            return base

    # 2. Common phrase shortenings
    replacements = [
        ('Maple Brown Sugar Instant Oatmeal', 'Maple Oatmeal'),
        ('Pineapple Grapefruit Juice', 'Grapefruit Juice'),
        ('Pineapple Orange Juice', 'Orange Pineapple Juice'),
        ('Reduced Fat Cheddar Cheese', 'Low-Fat Cheddar'),
        ('Reduced Fat Cottage Cheese', 'Low-Fat Cottage Cheese'),
        ('Shredded Mozzarella Cheese', 'Mozzarella Cheese'),
        ('Grated Parmesan Cheese', 'Parmesan Cheese'),
        ('Pasteurized Process', 'Processed'),
        ('Cheese Spread (American Or Cheddar Cheese Base, Reduced Fat)', 'Cheddar Cheese Spread'),
        ('Nonfat Greek Vanilla Yogurt', 'Nonfat Greek Yogurt'),
        ('Low-Fat Vanilla Yogurt', 'Low-Fat Yogurt'),
        ('Low-Fat Fruit Yogurt', 'Fruit Yogurt'),
        ('Skim Milk (Nonfat)', 'Skim Milk'),
        ('Reduced Fat Milk (2%)', '2% Milk'),
        ('Low-Fat Milk (1%)', '1% Milk'),
        ('Ghee (Clarified Butter)', 'Ghee Butter'),
        ('Peanut Butter (Smooth)', 'Smooth Peanut Butter'),
        ('Peanut Butter (Crunchy)', 'Crunchy Peanut Butter'),
        ('Tahini (Sesame Paste)', 'Tahini (Sesame)'),
        ('Corn Flour (Masa Harina)', 'Masa Harina Flour'),
        ('Whole Wheat Paratha', 'Wheat Paratha'),
        ('Whole Wheat Naan', 'Wheat Naan'),
        ('Whole Wheat Roti', 'Wheat Roti'),
        ('Frosted Toaster Pastries', 'Toaster Pastries'),
        ('Peanut Butter Cookies', 'Peanut Butter Cookie'),
        ('Brown Rice (Long Grain, Raw)', 'Brown Rice (Raw)'),
        ('Brown Rice (Long Grain, Cooked)', 'Brown Rice (Cooked)'),
        ('White Rice (Long Grain, Raw)', 'White Rice (Raw)'),
        ('White Rice (Long Grain, Cooked)', 'White Rice (Cooked)'),
        ('Brown Rice Pasta (Cooked)', 'Brown Rice Pasta'),
        ('Whole Wheat Pasta (Cooked)', 'Whole Wheat Pasta'),
        ('Egg White (Hard-Boiled)', 'Hard-Boiled Egg White'),
        ('Whole Egg (Hard-Boiled)', 'Hard-Boiled Egg'),
        ('Whole Egg (Dried)', 'Dried Whole Egg'),
        ('Whole Egg (Raw)', 'Whole Egg (Raw)'),
        ('Egg White (Raw)', 'Egg White (Raw)'),
        ('Egg Yolk (Raw)', 'Egg Yolk (Raw)'),
        ('Chicken Breast (Skinless, Cooked)', 'Chicken Breast (Cooked)'),
        ('Chicken Breast (Skinless, Raw)', 'Chicken Breast (Raw)'),
        ('Chicken Thigh (Skinless, Cooked)', 'Chicken Thigh (Cooked)'),
        ('Chicken Thigh (Skinless, Raw)', 'Chicken Thigh (Raw)'),
        ('Chicken Drumstick (Skinless, Cooked)', 'Chicken Drumstick'),
        ('Ground Beef (90/10 Lean, Cooked)', 'Ground Beef (90/10)'),
        ('Ground Beef (90/10 Lean, Raw)', 'Ground Beef (90/10)'),
        ('Ground Beef (85/15, Cooked)', 'Ground Beef (85/15)'),
        ('Ground Beef (80/20, Cooked)', 'Ground Beef (80/20)'),
        ('Beef Liver (Cooked)', 'Beef Liver (Cooked)'),
        ('Beef Liver (Raw)', 'Beef Liver (Raw)'),
        ('Atlantic Salmon (Cooked)', 'Atlantic Salmon'),
        ('Atlantic Salmon (Raw)', 'Atlantic Salmon (Raw)'),
        ('Sockeye Salmon (Raw)', 'Sockeye Salmon (Raw)'),
        ('Sockeye Salmon (Canned)', 'Sockeye Salmon (Can)'),
        ('Pink Salmon (Canned)', 'Pink Salmon (Canned)'),
        ('Pink Salmon (Raw)', 'Pink Salmon (Raw)'),
        ('Canned Sardines (in Oil)', 'Sardines in Oil'),
        ('Canned Sardines (in Tomato Sauce)', 'Sardines in Tomato'),
        ('Canned Tuna (in Water)', 'Canned Tuna (Water)'),
        ('Canned Tuna (in Oil)', 'Canned Tuna (Oil)'),
        ('Bread (Salvadoran Sweet Cheese (Quesadilla Salvadorena))', 'Salvadoran Quesadilla'),
        ('Edamame (Soybeans)', 'Edamame (Soybeans)'),
    ]

    for old_s, new_s in replacements:
        if title == old_s or old_s in title:
            title = title.replace(old_s, new_s)
            if len(title) <= 24:
                return title

    # If still > 24, strip trailing words or parentheses
    if len(title) > 24 and '(' in title:
        title = re.sub(r'\(.*?\)', '', title).strip()

    if len(title) > 24:
        words = title.split()
        truncated = ""
        for w in words:
            if len(f"{truncated} {w}".strip()) <= 24:
                truncated = f"{truncated} {w}".strip()
            else:
                break
        if len(truncated) >= 4:
            return truncated
        return title[:24].strip()

    return title

# Test on all foods
updated_titles = []
for f in foods:
    t = f.get('title', '')
    name = f.get('name', '')
    cat = f.get('category', '')
    new_t = constrain_title_to_24(t, name, cat)
    updated_titles.append((f, new_t))

over_24 = [t for _, t in updated_titles if len(t) > 24]
print(f"Total foods: {len(foods)}")
print(f"Titles still over 24 chars: {len(over_24)}")

if len(over_24) > 0:
    for t in over_24[:10]:
        print(f"  [{len(t)}]: {t}")
else:
    print("ALL 1,804 titles are strictly <= 24 characters!")
