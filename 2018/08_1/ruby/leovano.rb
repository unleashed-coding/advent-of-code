# frozen_string_literal: true

raise 'Arg1' if ARGV[0].nil?

input = File.read(ARGV[0]).split.map(&:to_i)

def metas(tree)
  ch, mt = tree.take 2

  pos = 2
  res = 0

  unless ch.zero?
    res += ch.times.reduce(0) do |acc|
      child = metas tree[pos..-1]
      pos += child[1]
      acc + child[0]
    end
  end

  res += tree[pos..-1].take(mt).sum
  [res, pos + mt]
end

puts metas(input).first
