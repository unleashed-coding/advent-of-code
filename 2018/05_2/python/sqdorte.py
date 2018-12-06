from math import inf

with open('input', 'r') as raw:
    polymer = raw.read().strip()

l = inf

for char in set(polymer.lower()):
    poly = polymer.replace(char, '').replace(char.upper(), '')

    i = 0

    while i != len(poly) -1:
        x,y = poly[i], poly[i+1]
        if x.lower() == y.lower() and x != y:
            poly = poly[:i] + poly[i+2:]
            i -= 1
        else:
            i += 1

    h = len(poly)

    if h < l:
        l = h

print(l)