with open('input', 'r') as raw:
    input = raw.read().split('\n')

frequency = 0

for change in input:
    frequency += int(change)

print(frequency)