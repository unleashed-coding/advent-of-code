# 
# LEMBRA DE TIRAR O INPUT CARAJOOOOOOO
# 

with open('input', 'r') as raw:
    i = raw.read().strip().split('\n')

c2 = 0
c3 = 0

for box in i:
    counts = set(map(box.count, set(box)))
    counts.remove(1)

    if 2 in counts:
        c2 += 1
    if 3 in counts:
        c3 += 1

print(c2*c3)