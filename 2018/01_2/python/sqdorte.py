with open('input', 'r') as raw:
    input = raw.read().split('\n')

frequency = 0
reached = [0]
find = False

while not find:
    for change in input:
        frequency += int(change)

        if frequency in reached:
            print(frequency)
            find = True
            break
        else:
            reached.append(frequency)

#print(reached)