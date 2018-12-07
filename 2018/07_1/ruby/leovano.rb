# frozen_string_literal: true

input = File.readlines(ARGV[0])

RULE = /^Step ([a-zA-Z]+) .* step ([a-zA-Z]+) can begin.$/.freeze
input.map! { |line| line.match(RULE).captures }

dependents = input.group_by(&:first).transform_values { |it| it.map(&:last) }
dependencies = input.group_by(&:last).transform_values { |it| it.map(&:first) }

dependents.default_proc = proc { |h, k| h[k] = [] }
dependencies.default_proc = proc { |h, k| h[k] = [] }

steps_done = []
steps_current = dependents.keys.select { |k| dependencies[k].empty? }

while steps_done.size < dependencies.size
  steps_current.sort!

  next_task = steps_current.find do |task|
    (dependencies[task] - steps_done).empty?
  end

  steps_done << steps_current.delete(next_task)
  steps_current += dependents[next_task]
end

puts steps_done.join
