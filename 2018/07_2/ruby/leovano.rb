# frozen_string_literal: true

raise "Arg1" if ARGV[0].nil?
input = File.readlines(ARGV[0])

RULE = /^Step ([a-zA-Z]+) .* step ([a-zA-Z]+) can begin.$/.freeze
input.map! { |line| line.match(RULE).captures }

dependents = input.group_by(&:first).transform_values { |it| it.map(&:last) }
dependencies = input.group_by(&:last).transform_values { |it| it.map(&:first) }

dependents.default_proc = proc { |h, k| h[k] = [] }
dependencies.default_proc = proc { |h, k| h[k] = [] }

steps_done = []
steps_current = dependents.keys.select { |k| dependencies[k].empty? }

workers = []
MAXWORKERS = 5
elapsed = 0

while steps_done.size < dependencies.size
  steps_current.sort!
  steps_current.uniq!

  is_ready = ->(task) { (dependencies[task] - steps_done).empty? }
  workers += steps_current
             .select(&is_ready)
             .take(MAXWORKERS - workers.size)
             .map { |sleight| [sleight, 61 + ('A'..'Z').find_index(sleight)] }
             .each { |sleight| steps_current.delete(sleight[0]) }

  min = workers.map(&:last).min
  workers.map! { |worker, secs| [worker, secs - min] }

  workers.select { |it| it[1].zero? }.each do |worker|
    workers.slice! workers.index worker
    steps_done << worker[0]
    steps_current += dependents[worker[0]]
  end

  elapsed += min
end

puts elapsed
