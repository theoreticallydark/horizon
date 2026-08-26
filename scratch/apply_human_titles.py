import json
import re

with open('sources/dri_and_foods.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

foods = data['sources']['foods']['foods']

def clean_food_title(f):
    name = f.get('name', '')
    cat = f.get('category', '')
    
    # 1. Clean boilerplate metadata
    name = re.sub(r'\(Includes foods for USDA.*?\)', '', name, flags=re.IGNORECASE)
    name = re.sub(r'\(include.*?\)', '', name, flags=re.IGNORECASE)
    name = re.sub(r'\(formerly.*?\)', '', name, flags=re.IGNORECASE)
    name = re.sub(r'\(approx.*?\)', '', name, flags=re.IGNORECASE)
    name = re.sub(r'\(dry.*?\)', '', name, flags=re.IGNORECASE)
    name = re.sub(r'NFS', '', name)
    name = name.strip(' ,;')

    parts = [p.strip() for p in name.split(',') if p.strip()]
    if not parts:
        return name

    p0 = parts[0]
    p0_lower = p0.lower()
    full_lower = name.lower()

    # --- SPECIFIC COMMON STAPLES & BRAND FIXES ---
    if 'chapati' in full_lower or 'roti' in full_lower:
        return 'Whole Wheat Roti' if 'whole' in full_lower else 'Roti'
    if 'paratha' in full_lower:
        return 'Whole Wheat Paratha' if 'whole' in full_lower else 'Paratha'
    if 'naan' in full_lower:
        return 'Whole Wheat Naan' if 'whole' in full_lower else 'Naan'
    if 'toaster pastries' in full_lower:
        return 'Frosted Toaster Pastries' if 'frosted' in full_lower else 'Toaster Pastries'
    if 'garlic bread' in full_lower:
        return 'Garlic Bread'
    if 'bagel' in full_lower:
        return 'Plain Bagel' if 'plain' in full_lower else 'Bagel'
    if 'peanut butter cookie' in full_lower or ('cookie' in full_lower and 'peanut butter' in full_lower):
        return 'Peanut Butter Cookies'
    if 'salt' in full_lower and ('table' in full_lower or 'iodized' in full_lower):
        return 'Iodized Table Salt' if 'iodized' in full_lower else 'Table Salt'

    # --- BEVERAGES & JUICES ---
    if 'almond milk' in full_lower:
        if 'chocolate' in full_lower: return 'Chocolate Almond Milk'
        if 'unsweetened' in full_lower: return 'Unsweetened Almond Milk'
        return 'Almond Milk'
    if 'oat milk' in full_lower:
        if 'unsweetened' in full_lower: return 'Unsweetened Oat Milk'
        return 'Oat Milk'
    if 'cranberry-apple juice' in full_lower or 'cranberry apple' in full_lower:
        return 'Cranberry Apple Juice'
    if 'apple juice' in full_lower:
        if 'unsweetened' in full_lower: return 'Unsweetened Apple Juice'
        return 'Apple Juice'
    if 'orange juice' in full_lower or ('orange' in full_lower and 'juice' in full_lower):
        if 'apricot' in full_lower: return 'Orange Apricot Juice'
        if 'pineapple' in full_lower: return 'Pineapple Orange Juice'
        if 'calcium' in full_lower: return 'Orange Juice (Fortified)'
        return 'Orange Juice'
    if 'grapefruit juice' in full_lower or ('grapefruit' in full_lower and 'juice' in full_lower):
        return 'Pineapple Grapefruit Juice' if 'pineapple' in full_lower else 'Grapefruit Juice'
    if 'grape juice' in full_lower:
        return 'Grape Juice'
    if 'tomato juice' in full_lower:
        return 'Tomato Juice'
    if 'prune juice' in full_lower:
        return 'Prune Juice'
    if 'pomegranate juice' in full_lower:
        return 'Pomegranate Juice'
    if 'lemon juice' in full_lower:
        return 'Fresh Lemon Juice' if 'raw' in full_lower or 'fresh' in full_lower else 'Lemon Juice'
    if 'lime juice' in full_lower:
        return 'Fresh Lime Juice' if 'raw' in full_lower or 'fresh' in full_lower else 'Lime Juice'

    # --- CEREALS & GRAINS ---
    if 'pumpkin granola' in full_lower:
        return 'Pumpkin Flax Granola'
    if 'honey bunches of oats' in full_lower:
        return 'Honey Bunches of Oats'
    if 'chia seeds' in full_lower or 'chia seed' in full_lower:
        return 'Chia Seeds'
    if 'flaxseed' in full_lower or 'flax seed' in full_lower:
        return 'Ground Flaxseed' if 'ground' in full_lower else 'Flaxseed'
    if 'sunflower seed' in full_lower:
        return 'Sunflower Seeds'
    if 'pumpkin seed' in full_lower:
        return 'Pumpkin Seeds'

    # Oats
    if 'oat' in p0_lower or 'oats' in p0_lower or ('cereal' in p0_lower and 'oat' in full_lower):
        if 'steel cut' in full_lower: return 'Steel Cut Oats'
        if 'rolled' in full_lower or 'old fashioned' in full_lower: return 'Rolled Oats'
        if 'instant' in full_lower:
            if 'maple' in full_lower or 'brown sugar' in full_lower: return 'Maple Brown Sugar Instant Oatmeal'
            return 'Instant Oatmeal'
        if 'flour' in full_lower: return 'Oat Flour'
        if 'bran' in full_lower: return 'Oat Bran'
        if 'cooked' in full_lower: return 'Cooked Oatmeal'
        return 'Rolled Oats'

    # Rice
    if 'rice' in p0_lower or ('cereal' in p0_lower and 'rice' in full_lower):
        color = 'Brown' if 'brown' in full_lower else ('Black' if 'black' in full_lower else ('Red' if 'red' in full_lower else ('Wild' if 'wild' in full_lower else 'White')))
        state = 'Cooked' if 'cooked' in full_lower else ('Raw' if 'raw' in full_lower else '')
        grain = 'Long Grain' if 'long' in full_lower else ('Basmati' if 'basmati' in full_lower else ('Jasmine' if 'jasmine' in full_lower else ''))
        mods = [m for m in [grain, state] if m]
        mod_str = f" ({', '.join(mods)})" if mods else ""
        return f"{color} Rice{mod_str}"

    # Pasta & Noodles
    if 'pasta' in p0_lower or 'noodles' in p0_lower:
        state = 'Cooked' if 'cooked' in full_lower else ('Dry' if 'dry' in full_lower or 'uncooked' in full_lower else '')
        base = 'Whole Wheat Pasta' if 'whole wheat' in full_lower or 'whole-wheat' in full_lower else ('Egg Noodles' if 'egg' in full_lower else ('Brown Rice Pasta' if 'brown rice' in full_lower else ('Quinoa Pasta' if 'quinoa' in full_lower else 'Pasta')))
        return f"{base} ({state})" if state else base

    # Quinoa, Barley, Millet, Farro, Sorghum
    if 'quinoa' in p0_lower or 'quinoa' in full_lower:
        if 'flour' in full_lower: return 'Quinoa Flour'
        return 'Cooked Quinoa' if 'cooked' in full_lower else 'Quinoa'
    if 'barley' in p0_lower:
        if 'flour' in full_lower: return 'Barley Flour'
        return 'Cooked Pearled Barley' if 'cooked' in full_lower else 'Pearled Barley'
    if 'millet' in p0_lower:
        return 'Cooked Millet' if 'cooked' in full_lower else 'Millet'
    if 'farro' in p0_lower:
        return 'Pearled Farro'
    if 'sorghum' in p0_lower:
        return 'Sorghum Flour' if 'flour' in full_lower else 'Sorghum Grain'

    # Flours
    if 'flour' in p0_lower:
        desc = ' '.join(parts[1:]).lower()
        if 'whole wheat' in desc: return 'Whole Wheat Flour'
        if 'bread' in desc: return 'Bread Flour'
        if 'buckwheat' in desc: return 'Buckwheat Flour'
        if 'brown rice' in desc: return 'Brown Rice Flour'
        if 'glutinous' in desc: return 'Glutinous Rice Flour'
        if 'rice' in desc: return 'White Rice Flour'
        if 'corn' in desc or 'masa' in desc: return 'Corn Flour (Masa Harina)' if 'masa' in desc else 'Corn Flour'
        if 'all-purpose' in desc: return 'All-Purpose Flour'
        return f"{parts[1].title()} Flour" if len(parts) > 1 else "Flour"

    # --- EGGS ---
    if p0_lower in ['egg', 'eggs']:
        desc = ' '.join(parts[1:]).lower()
        if 'white' in desc:
            form = 'Hard-Boiled' if 'hard-boiled' in desc or 'boiled' in desc else ('Fried' if 'fried' in desc else ('Scrambled' if 'scrambled' in desc else ('Dried' if 'dried' in desc else '')))
            state = ' (Raw)' if 'raw' in desc or 'fresh' in desc else (f' ({form})' if form else '')
            return f"Egg White{state}"
        if 'yolk' in desc:
            state = ' (Raw)' if 'raw' in desc or 'fresh' in desc else (' (Dried)' if 'dried' in desc else '')
            return f"Egg Yolk{state}"
        if 'duck' in desc: return "Duck Egg"
        if 'quail' in desc: return "Quail Egg"
        if 'goose' in desc: return "Goose Egg"
        if 'hard-boiled' in desc or 'boiled' in desc: return "Hard-Boiled Egg"
        if 'scrambled' in desc: return "Scrambled Eggs"
        if 'fried' in desc: return "Fried Egg"
        if 'poached' in desc: return "Poached Egg"
        if 'omelet' in desc: return "Egg Omelet"
        if 'raw' in desc or 'fresh' in desc: return "Whole Egg (Raw)"
        if 'dried' in desc: return "Whole Egg (Dried)"
        return "Whole Egg"

    # --- DAIRY (Cheese, Milk, Yogurt, Butter) ---
    if p0_lower == 'cheese':
        desc = ' '.join(parts[1:]).lower()
        types = ['cheddar', 'mozzarella', 'parmesan', 'swiss', 'feta', 'provolone', 'ricotta', 'brie', 'gouda', 'cottage', 'cream', 'monterey jack', 'monterey', 'blue', 'colby', 'muenster', 'romano', 'goat', 'neufchatel', 'queso fresco', 'queso seco', 'cotija', 'oaxaca', 'american']
        matched_type = None
        for t in types:
            if t in desc:
                matched_type = t.title()
                break
        if matched_type:
            mods = []
            if 'sharp' in desc: mods.append('Sharp')
            if 'low-fat' in desc or 'lowfat' in desc or 'reduced fat' in desc or 'part skim' in desc or 'low fat' in desc: mods.append('Reduced Fat')
            elif 'nonfat' in desc or 'fat free' in desc: mods.append('Nonfat')
            if 'grated' in desc: mods.append('Grated')
            if 'shredded' in desc: mods.append('Shredded')
            mod_str = ' '.join(mods)
            if 'Cheese' in matched_type:
                return f"{mod_str} {matched_type}".strip()
            return f"{mod_str} {matched_type} Cheese".strip()
        if 'spread' in desc: return 'Cheese Spread'
        return f"{parts[1].title()} Cheese" if len(parts) > 1 else "Cheese"

    if p0_lower == 'milk':
        desc = ' '.join(parts[1:]).lower()
        if 'chocolate' in desc: return "Chocolate Milk"
        if 'nonfat' in desc or 'skim' in desc or 'fat free' in desc: return "Skim Milk (Nonfat)"
        if 'lowfat' in desc or '1%' in desc: return "Low-Fat Milk (1%)"
        if 'reduced fat' in desc or '2%' in desc: return "Reduced Fat Milk (2%)"
        if 'whole' in desc or '3.25%' in desc: return "Whole Milk"
        if 'buttermilk' in desc: return "Buttermilk"
        if 'evaporated' in desc: return "Evaporated Milk"
        if 'condensed' in desc: return "Condensed Milk"
        return "Whole Milk"

    if p0_lower == 'yogurt':
        desc = ' '.join(parts[1:]).lower()
        greek = 'Greek ' if 'greek' in desc else ''
        plain = 'Plain ' if 'plain' in desc else ''
        fat = 'Nonfat ' if ('nonfat' in desc or 'fat free' in desc or '0%' in desc) else ('Low-Fat ' if 'low fat' in desc or 'lowfat' in desc else '')
        flavor = 'Vanilla ' if 'vanilla' in desc else ('Fruit ' if 'fruit' in desc or 'strawberry' in desc or 'blueberry' in desc else '')
        title = f"{fat}{greek}{flavor}{plain}Yogurt".strip()
        return title if title else "Yogurt"

    if p0_lower == 'butter':
        desc = ' '.join(parts[1:]).lower()
        if 'unsalted' in desc or 'without salt' in desc: return "Unsalted Butter"
        if 'salted' in desc or 'with salt' in desc: return "Salted Butter"
        if 'whipped' in desc: return "Whipped Butter"
        if 'ghee' in desc or 'clarified' in desc: return "Ghee (Clarified Butter)"
        return "Butter"

    # --- VEGETABLES ---
    if cat == 'Vegetables and Vegetable Products':
        veg = p0.title()
        desc = ' '.join(parts[1:]).lower()
        state = 'Cooked' if 'cooked' in desc or 'boiled' in desc or 'steamed' in desc else ('Raw' if 'raw' in desc else '')
        form = 'Canned' if 'canned' in desc else ('Frozen' if 'frozen' in desc else ('Dried' if 'dried' in desc or 'dehydrated' in desc else ''))
        mods = [m for m in [form, state] if m]
        mod_str = f" ({', '.join(mods)})" if mods else ""
        if 'spinach' in veg.lower(): return f"Spinach{mod_str}"
        if 'broccoli' in veg.lower(): return f"Broccoli{mod_str}"
        if 'carrot' in veg.lower():
            variety = 'Baby Carrots' if 'baby' in full_lower else 'Carrots'
            return f"{variety}{mod_str}"
        if 'potato' in veg.lower() or 'potatoes' in veg.lower():
            p_type = 'Sweet Potato' if 'sweet' in full_lower else ('Russet Potato' if 'russet' in full_lower else ('Red Potato' if 'red' in full_lower else 'Potato'))
            if 'baked' in desc: return f"Baked {p_type}"
            if 'mashed' in desc: return f"Mashed {p_type}"
            if 'french fried' in desc or 'fries' in desc: return "French Fries"
            return f"{p_type}{mod_str}"
        if 'kale' in veg.lower(): return f"Kale{mod_str}"
        if 'garlic' in veg.lower(): return f"Garlic{mod_str}"
        if 'onion' in veg.lower() or 'onions' in veg.lower(): return f"Onions{mod_str}"
        if 'tomato' in veg.lower() or 'tomatoes' in veg.lower():
            if 'sauce' in desc: return "Tomato Sauce"
            if 'paste' in desc: return "Tomato Paste"
            if 'crushed' in desc: return "Crushed Tomatoes"
            return f"Tomatoes{mod_str}"
        if 'avocado' in veg.lower() or 'avocados' in veg.lower(): return "Avocado"
        return f"{veg}{mod_str}"

    # --- FRUITS ---
    if cat == 'Fruits and Fruit Juices':
        fruit = p0.title()
        desc = ' '.join(parts[1:]).lower()
        state = 'Raw' if 'raw' in desc else ('Dried' if 'dried' in desc else ('Canned' if 'canned' in desc else ('Frozen' if 'frozen' in desc else '')))
        state_str = f" ({state})" if state and state != 'Raw' else ""
        if 'apple' in fruit.lower():
            varieties = ['Fuji', 'Gala', 'Granny Smith', 'Honeycrisp', 'Red Delicious', 'Golden Delicious']
            for v in varieties:
                if v.lower() in full_lower:
                    return f"{v} Apple"
            return f"Apple{state_str}"
        if 'banana' in fruit.lower(): return f"Banana{state_str}"
        if 'orange' in fruit.lower(): return f"Orange{state_str}"
        if 'guava' in fruit.lower(): return f"Guava{state_str}"
        if 'blueberry' in fruit.lower() or 'blueberries' in fruit.lower(): return f"Blueberries{state_str}"
        if 'strawberry' in fruit.lower() or 'strawberries' in fruit.lower(): return f"Strawberries{state_str}"
        if 'raspberry' in fruit.lower() or 'raspberries' in fruit.lower(): return f"Raspberries{state_str}"
        if 'blackberry' in fruit.lower() or 'blackberries' in fruit.lower(): return f"Blackberries{state_str}"
        if 'watermelon' in fruit.lower(): return "Watermelon"
        if 'cantaloupe' in fruit.lower(): return "Cantaloupe"
        if 'mango' in fruit.lower() or 'mangoes' in fruit.lower(): return f"Mango{state_str}"
        if 'papaya' in fruit.lower(): return f"Papaya{state_str}"
        if 'kiwi' in fruit.lower(): return "Kiwi"
        if 'grape' in fruit.lower() or 'grapes' in fruit.lower(): return "Grapes"
        if 'lemon' in fruit.lower(): return "Lemon"
        if 'lime' in fruit.lower(): return "Lime"
        return f"{fruit}{state_str}"

    # --- NUTS & SEEDS ---
    if cat == 'Nut and Seed Products' or 'nuts' in p0_lower or 'seeds' in p0_lower:
        desc = ' '.join(parts).lower()
        if 'almond' in desc: return "Roasted Almonds" if 'roasted' in desc else "Raw Almonds"
        if 'walnut' in desc: return "Walnuts"
        if 'cashew' in desc: return "Roasted Cashews" if 'roasted' in desc else "Raw Cashews"
        if 'peanut' in desc:
            if 'butter' in desc: return "Peanut Butter (Smooth)" if 'smooth' in desc or 'creamy' in desc else ("Peanut Butter (Crunchy)" if 'chunky' in desc else "Peanut Butter")
            return "Roasted Peanuts" if 'roasted' in desc else "Peanuts"
        if 'pistachio' in desc: return "Pistachios"
        if 'pecan' in desc: return "Pecans"
        if 'brazil nut' in desc: return "Brazil Nuts"
        if 'macadamia' in desc: return "Macadamia Nuts"
        if 'hazelnut' in desc: return "Hazelnuts"
        if 'sunflower' in desc: return "Sunflower Seeds"
        if 'pumpkin' in desc: return "Pumpkin Seeds"
        if 'sesame' in desc:
            if 'tahini' in desc or 'paste' in desc or 'butter' in desc: return "Tahini (Sesame Paste)"
            return "Sesame Seeds"
        if 'flax' in desc: return "Ground Flaxseed" if 'ground' in desc else "Flaxseed"
        if 'chia' in desc: return "Chia Seeds"

    # --- MEATS & POULTRY & SEAFOOD ---
    if cat in ['Beef Products', 'Poultry Products', 'Pork Products', 'Lamb, Veal, and Game Products', 'Finfish and Shellfish Products']:
        desc = ' '.join(parts).lower()
        if 'salmon' in desc:
            state = 'Cooked' if 'cooked' in desc or 'baked' in desc or 'broiled' in desc or 'grilled' in desc else ('Smoked' if 'smoked' in desc else ('Canned' if 'canned' in desc else 'Raw'))
            variety = 'Atlantic ' if 'atlantic' in desc else ('Sockeye ' if 'sockeye' in desc else ('Pink ' if 'pink' in desc else ('Coho ' if 'coho' in desc else 'Wild ')))
            return f"{variety}Salmon ({state})".strip()
        if 'tuna' in desc:
            if 'canned' in desc:
                liquid = 'in Water' if 'water' in desc else ('in Oil' if 'oil' in desc else '')
                return f"Canned Tuna{f' ({liquid})' if liquid else ''}"
            return "Fresh Tuna (Cooked)" if 'cooked' in desc else "Fresh Tuna (Raw)"
        if 'cod' in desc: return "Pacific Cod" if 'pacific' in desc else ("Atlantic Cod" if 'atlantic' in desc else "Cod Fish")
        if 'tilapia' in desc: return "Cooked Tilapia" if 'cooked' in desc else "Tilapia"
        if 'shrimp' in desc: return "Cooked Shrimp" if 'cooked' in desc else "Raw Shrimp"
        if 'sardine' in desc or 'sardines' in desc: return "Canned Sardines (in Oil)" if 'oil' in desc else ("Canned Sardines (in Tomato Sauce)" if 'tomato' in desc else "Canned Sardines")
        if 'mackerel' in desc: return "Mackerel (Cooked)" if 'cooked' in desc else "Mackerel"
        if 'anchovy' in desc or 'anchovies' in desc: return "Canned Anchovies"

        # Poultry
        if 'chicken' in desc:
            cut = 'Breast' if 'breast' in desc else ('Thigh' if 'thigh' in desc else ('Drumstick' if 'drumstick' in desc else ('Wing' if 'wing' in desc else ('Liver' if 'liver' in desc else ''))))
            state = 'Cooked' if 'cooked' in desc or 'roasted' in desc or 'grilled' in desc or 'fried' in desc else ('Raw' if 'raw' in desc else '')
            skin = 'Skinless' if 'without skin' in desc or 'meat only' in desc else ('With Skin' if 'with skin' in desc else '')
            mods = [m for m in [skin, state] if m]
            mod_str = f" ({', '.join(mods)})" if mods else ""
            if cut: return f"Chicken {cut}{mod_str}"
            if 'ground' in desc: return f"Ground Chicken{mod_str}"
            return f"Chicken Meat{mod_str}"

        if 'turkey' in desc:
            cut = 'Breast' if 'breast' in desc else ('Thigh' if 'thigh' in desc else ('Bacon' if 'bacon' in desc else ('Liver' if 'liver' in desc else '')))
            state = 'Cooked' if 'cooked' in desc or 'roasted' in desc else ('Raw' if 'raw' in desc else '')
            mods = [m for m in [state] if m]
            mod_str = f" ({', '.join(mods)})" if mods else ""
            if cut: return f"Turkey {cut}{mod_str}"
            if 'ground' in desc: return f"Ground Turkey{mod_str}"
            return f"Turkey Meat{mod_str}"

        # Beef
        if 'beef' in desc:
            if 'ground' in desc:
                fat = '90/10 Lean' if '90%' in desc or '10% fat' in desc or '93%' in desc or '95%' in desc else ('85/15' if '85%' in desc or '15% fat' in desc else ('80/20' if '80%' in desc or '20% fat' in desc else 'Lean'))
                state = 'Cooked' if 'cooked' in desc or 'pan-browned' in desc or 'broiled' in desc else ('Raw' if 'raw' in desc else '')
                return f"Ground Beef ({fat}, {state})".replace(', )', ')').strip()
            if 'liver' in desc: return "Beef Liver (Cooked)" if 'cooked' in desc else "Beef Liver (Raw)"
            if 'ribeye' in desc or 'rib eye' in desc: return "Ribeye Steak"
            if 'sirloin' in desc: return "Sirloin Steak"
            if 'tenderloin' in desc or 'filet mignon' in desc: return "Beef Tenderloin"
            if 'brisket' in desc: return "Beef Brisket"
            if 'flank' in desc: return "Flank Steak"
            if 't-bone' in desc or 'porterhouse' in desc: return "T-Bone Steak"
            if 'chuck' in desc: return "Beef Chuck Roast"
            state = 'Cooked' if 'cooked' in desc else ('Raw' if 'raw' in desc else '')
            cut_title = parts[1].title() if len(parts) > 1 else 'Steak'
            return f"Beef {cut_title} ({state})" if state else f"Beef {cut_title}"

        # Pork
        if 'pork' in desc:
            if 'bacon' in desc: return "Cooked Bacon" if 'cooked' in desc else "Bacon"
            if 'chop' in desc or 'chops' in desc: return "Pork Chop (Cooked)" if 'cooked' in desc else "Pork Chop"
            if 'tenderloin' in desc: return "Pork Tenderloin"
            if 'loin' in desc: return "Pork Loin Roast"
            if 'ground' in desc: return "Ground Pork"
            if 'sausage' in desc: return "Pork Sausage"
            if 'ham' in desc: return "Ham"
            return "Pork Meat"

    # --- LEGUMES ---
    if cat == 'Legumes and Legume Products' or 'beans' in full_lower or 'lentils' in full_lower or 'chickpeas' in full_lower:
        desc = ' '.join(parts).lower()
        state = 'Cooked' if 'cooked' in desc or 'boiled' in desc else ('Raw' if 'raw' in desc else ('Canned' if 'canned' in desc else ''))
        state_str = f" ({state})" if state else ""
        if 'black bean' in desc or 'black beans' in desc: return f"Black Beans{state_str}"
        if 'pinto' in desc: return f"Pinto Beans{state_str}"
        if 'kidney' in desc: return f"Kidney Beans{state_str}"
        if 'garbanzo' in desc or 'chickpea' in desc or 'chickpeas' in desc:
            if 'hummus' in desc: return "Hummus"
            return f"Chickpeas{state_str}"
        if 'lentil' in desc or 'lentils' in desc: return f"Lentils{state_str}"
        if 'edamame' in desc or 'soybeans, green' in desc: return f"Edamame (Soybeans){state_str}"
        if 'tofu' in desc:
            firmness = 'Extra Firm' if 'extra firm' in desc else ('Firm' if 'firm' in desc else ('Silken' if 'silken' in desc else 'Soft'))
            return f"{firmness} Tofu"
        if 'tempeh' in desc: return "Tempeh"
        if 'split pea' in desc or 'split peas' in desc: return f"Split Peas{state_str}"

    # --- GENERAL CLEANUP FALLBACK ---
    clean_parts = []
    for p in parts:
        p_clean = re.sub(r'\b(enriched|unenriched|commercially|prepared|regular|all varieties|includes|without salt|with salt|usda|nfs|raw|cooked)\b', '', p, flags=re.IGNORECASE).strip()
        p_clean = re.sub(r'\s+', ' ', p_clean).strip(' ,;')
        if p_clean and p_clean.lower() not in [c.lower() for c in clean_parts]:
            clean_parts.append(p_clean.title())
    
    if len(clean_parts) == 1:
        return clean_parts[0]
    elif len(clean_parts) == 2:
        return f"{clean_parts[0]} ({clean_parts[1]})"
    elif len(clean_parts) >= 3:
        return f"{clean_parts[0]} ({clean_parts[1]}, {clean_parts[2]})"
    
    return parts[0].title()

# Apply to dri_and_foods.json
updated_count = 0
for f in foods:
    new_title = clean_food_title(f)
    if f.get('title') != new_title:
        f['title'] = new_title
        updated_count += 1

print(f"Updated {updated_count} food titles in JSON object.")

with open('sources/dri_and_foods.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print("Saved updated sources/dri_and_foods.json successfully.")
