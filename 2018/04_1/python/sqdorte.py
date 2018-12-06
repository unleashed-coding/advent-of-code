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
        sleeptime = minute - start
        try:
            guards[guard][0] += sleeptime
        except KeyError:
            guards[guard] = [sleeptime, {}]

        for i in range(start, minute):
            try:
                guards[guard][1][i] += 1
            except KeyError:
                guards[guard][1][i] = 1
        change = False

guard = sorted(((guards[x][0],x) for x in guards))[-1][1]
sleep = guards[guard][1]
hour = list(zip(*sorted(zip(sleep.values(), sleep.keys()))))[1][-1]

print(int(guard)*hour)