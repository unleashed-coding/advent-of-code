with open('input', 'r') as raw:
    i = sorted(raw.read().strip().split('\n'))

guard = None
sleeping = False
start = None
change = False

guards = {}

for line in i:
    minute = int(line[15:17])

    if line[19] == 'f':
        sleeping = True
        start = minute
    elif line[19] == 'w':
        sleeping = False
        change = True
    else:
        if sleeping:
            sleeping = False
            change = True

        guard = line[26:].split(' ')[0]

    if change:
        for i in range(start, minute):
            try:
                guards[guard][i] += 1
            except KeyError:
                try:
                    guards[guard].update({i: 1})
                except KeyError:
                    guards[guard] = {i: 1}
        change = False

h = []

for guard in guards:
    sleep = guards[guard]
    hour = list(zip(*sorted(zip(sleep.values(), sleep.keys()))))[1][-1]

    h.append((sleep[hour], (hour, int(guard))))

guard,minute = list(zip(*sorted(h)))[-1][-1]
print(guard*minute)