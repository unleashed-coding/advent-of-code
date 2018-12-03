with open('input', 'r') as raw:
    i = raw.read().strip().split('\n')

claimed = {}
claims = []

for x in i:
    claim = x.split('@ ')
    
    cid = claim[0][1:]
    coords = claim[1].split(': ')

    a,b = map(int, coords[0].split(','))
    c,d = map(int, coords[1].split('x'))

    for x in range(a, a+c):
        for y in range(b, b+d):
            try:
                claimed[(x,y)] += 1
            except KeyError:
                claimed[(x,y)] = 1

    claims.append((cid,a,b,c,d))

for cid,a,b,c,d in claims:
    s = True
    for x in range(a, a+c):
        if not s:
            break
        for y in range(b, b+d):
            if claimed[(x,y)] > 1:
                s = False
                break
    if s:
        print(cid)
        break