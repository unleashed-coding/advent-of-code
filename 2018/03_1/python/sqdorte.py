with open('input', 'r') as raw:
    i = raw.read().strip().split('\n')

claimed = {}

for x in i:
    claim = x.split('@ ')[1].split(': ')

    a,b = map(int, claim[0].split(','))
    c,d = map(int, claim[1].split('x'))

    for x in range(a, a+c):
        for y in range(b, b+d):
            try:
                claimed[(x,y)] += 1
            except KeyError:
                claimed[(x,y)] = 1

print(sum(1 if x > 1 else 0 for x in claimed.values()))