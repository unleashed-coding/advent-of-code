with open('input', 'r') as raw:
    i = raw.read().strip().split('\n')

frequency = 0
reached = {0}
finded = False

while not finded:
    for change in i:
        frequency += int(change)

        if frequency in reached:
            print(frequency)
            finded = True
            break
        else:
            reached.update({frequency})