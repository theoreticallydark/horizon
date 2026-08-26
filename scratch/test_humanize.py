import json
import re

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']

def humanize_title(name, category):
    # Step 1: Clean boilerplate / USDA metadata
    raw = name
    raw = re.sub(r'\(Includes foods for USDA.*?\)', '', raw, flags=re.IGNORECASE)
    raw = re.sub(r'\(include.*?\)', '', raw, flags=re.IGNORECASE)
    raw = re.sub(r'\(formerly.*?\)', '', raw, flags=re.IGNORECASE)
    raw = re.sub(r'\(approx.*?\)', '', raw, flags=re.IGNORECASE)
    raw = re.sub(r'\(dry.*?\)', '', raw, flags=re.IGNORECASE)
    raw = re.sub(r'NFS', '', raw)
    
    # Common USDA prefix removal based on category
    prefixes_to_strip = [
        'Beverages, ', 'Bread, ', 'Cereals ready-to-eat, ', 'Cereals, ', 'Cheese, ',
        'Cookies, ', 'Crackers, ', 'Egg, ', 'Fish, ', 'Flour, ', 'Milk, ', 'Noodles, ',
        'Nuts, ', 'Oil, ', 'Pasta, ', 'Pork, ', 'Poultry, ', 'Rice, ', 'Seeds, ',
        'Snacks, ', 'Soup, ', 'Spices, ', 'Vegetables, ', 'Yogurt, ', 'Beef, ',
        'Chicken, ', 'Turkey, ', 'Lamb, ', 'Veal, ', 'Game meat, ', 'Beans, '
    ]
    
    # Specific category heuristics:
    parts = [p.strip() for p in raw.split(',') if p.strip()]
    
    # Handle eggs
    if parts[0].lower() == 'egg' or parts[0].lower() == 'eggs':
        # e.g. Egg, whole, raw, fresh -> Whole Egg (Raw)
        # e.g. Egg, whole, cooked, hard-boiled -> Hard-Boiled Egg
        # e.g. Egg, white, raw, fresh -> Egg White (Raw)
        # e.g. Egg, yolk, raw, fresh -> Egg Yolk (Raw)
        desc = ' '.join(parts[1:]).lower()
        if 'white' in desc:
            state = 'Cooked' if 'cooked' in desc or 'boiled' in desc or 'fried' in desc else ('Raw' if 'raw' in desc else '')
            form = 'Hard-Boiled' if 'hard-boiled' in desc or 'boiled' in desc else ('Fried' if 'fried' in desc else ('Scrambled' if 'scrambled' in desc else ''))
            return f"Egg White{f' ({form or state})' if form or state else ''}"
        elif 'yolk' in desc:
            state = 'Cooked' if 'cooked' in desc or 'boiled' in desc or 'fried' in desc else ('Raw' if 'raw' in desc else '')
            return f"Egg Yolk{f' ({state})' if state else ''}"
        elif 'duck' in desc:
            return "Duck Egg"
        elif 'quail' in desc:
            return "Quail Egg"
        elif 'hard-boiled' in desc or 'boiled' in desc:
            return "Hard-Boiled Egg"
        elif 'scrambled' in desc:
            return "Scrambled Eggs"
        elif 'fried' in desc:
            return "Fried Egg"
        elif 'poached' in desc:
            return "Poached Egg"
        elif 'raw' in desc or 'fresh' in desc:
            return "Whole Egg (Raw)"
        elif 'dried' in desc:
            return "Whole Egg (Dried)"
        return "Whole Egg"

    # Handle Cheese
    if parts[0].lower() == 'cheese':
        # Cheese, cheddar, sharp -> Sharp Cheddar Cheese
        # Cheese, mozzarella, whole milk -> Whole Milk Mozzarella
        # Cheese, parmesan, grated -> Grated Parmesan
        desc = ' '.join(parts[1:]).lower()
        types = ['cheddar', 'mozzarella', 'parmesan', 'swiss', 'feta', 'provolone', 'ricotta', 'brie', 'gouda', 'cottage', 'cream', 'monterey', 'blue', 'colby', 'muenster', 'romano', 'goat', 'neufchatel', 'queso fresco', 'cotija', 'oaxaca']
        matched_type = None
        for t in types:
            if t in desc:
                matched_type = t.title()
                break
        if matched_type:
            mods = []
            if 'sharp' in desc: mods.append('Sharp')
            if 'low-fat' in desc or 'lowfat' in desc or 'reduced fat' in desc or 'part skim' in desc: mods.append('Reduced Fat')
            elif 'nonfat' in desc or 'fat free' in desc: mods.append('Nonfat')
            if 'grated' in desc: mods.append('Grated')
            if 'shredded' in desc: mods.append('Shredded')
            mod_str = ' '.join(mods)
            return f"{mod_str} {matched_type} Cheese".strip() if 'Cheese' not in matched_type else f"{mod_str} {matched_type}".strip()
        return f"Cheese ({parts[1].title()})" if len(parts) > 1 else "Cheese"

    # Handle Milk
    if parts[0].lower() == 'milk':
        desc = ' '.join(parts[1:]).lower()
        if 'chocolate' in desc:
            return "Chocolate Milk"
        if 'nonfat' in desc or 'skim' in desc or 'fat free' in desc:
            return "Skim Milk (Nonfat)"
        if 'lowfat' in desc or '1%' in desc:
            return "Low-Fat Milk (1%)"
        if 'reduced fat' in desc or '2%' in desc:
            return "Reduced Fat Milk (2%)"
        if 'whole' in desc or '3.25%' in desc:
            return "Whole Milk"
        if 'buttermilk' in desc:
            return "Buttermilk"
        if 'evaporated' in desc:
            return "Evaporated Milk"
        if 'condensed' in desc:
            return "Condensed Milk"
        return "Cow's Milk"

    # Handle Yogurt
    if parts[0].lower() == 'yogurt':
        desc = ' '.join(parts[1:]).lower()
        greek = 'Greek ' if 'greek' in desc else ''
        plain = 'Plain ' if 'plain' in desc else ''
        fat = 'Nonfat ' if ('nonfat' in desc or 'fat free' in desc or '0%' in desc) else ('Low-Fat ' if 'low fat' in desc or 'lowfat' in desc else '')
        flavor = 'Vanilla ' if 'vanilla' in desc else ('Fruit ' if 'fruit' in desc or 'strawberry' in desc or 'blueberry' in desc else '')
        title = f"{fat}{greek}{flavor}{plain}Yogurt".strip()
        return title if title else "Yogurt"

    # Generic: Title case and reorder
    # If first part is a category like "Bread", "Fish", "Beef", "Chicken", invert it
    if len(parts) > 1 and parts[0] in ['Bread', 'Fish', 'Beef', 'Chicken', 'Turkey', 'Pork', 'Lamb', 'Pasta', 'Rice', 'Flour', 'Oil', 'Nuts', 'Seeds', 'Beans', 'Juice', 'Tea', 'Coffee']:
        main = parts[1].title()
        lead = parts[0]
        extra = [p.title() for p in parts[2:] if not any(w in p.lower() for w in ['commercial', 'prepared', 'enriched', 'unenriched', 'usda', 'nfs', 'regular'])]
        extra_str = f" ({', '.join(extra)})" if extra else ""
        if lead.lower() in main.lower():
            return f"{main}{extra_str}"
        return f"{main} {lead}{extra_str}"

    # Default fallback
    clean_parts = [p.title() for p in parts if not any(w in p.lower() for w in ['commercial', 'prepared', 'enriched', 'unenriched', 'usda', 'nfs', 'regular'])]
    if len(clean_parts) == 1:
        return clean_parts[0]
    return f"{clean_parts[0]} ({', '.join(clean_parts[1:3])})"

# Test on 100 foods
for f in foods[100:150]:
    print(f"ORIGINAL: {f['name']}")
    print(f"CURRENT:  {f['title']}")
    print(f"HUMAN:    {humanize_title(f['name'], f['category'])}")
    print("-" * 40)
