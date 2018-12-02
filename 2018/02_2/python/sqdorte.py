from itertools import combinations

with open('input', 'r') as raw:
    i = raw.read().strip().split('\n')

for (w1,w2) in combinations(i, 2):
    diff = list(map(lambda x: x[0] == x[1],zip(w1, w2)))
    if diff.count(0) == 1:
        i = diff.index(0)
        print(w1[:i] + w1[i+1:])
        break