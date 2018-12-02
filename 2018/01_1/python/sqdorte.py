with open('input', 'r') as raw:
    i = raw.read().strip().split('\n')

frequency = 0

for change in i:
    frequency += int(change)

print(frequency)