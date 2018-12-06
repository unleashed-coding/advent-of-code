with open('input', 'r') as raw:
    polymer = raw.read().strip()

i = 0

while i != len(polymer) -1:
    x,y = polymer[i], polymer[i+1]
    if x.lower() == y.lower() and x != y:
        polymer = polymer[:i] + polymer[i+2:]
        i -= 1
    else:
        i += 1

print(len(polymer))