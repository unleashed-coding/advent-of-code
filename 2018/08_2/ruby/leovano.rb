# frozen_string_literal: true

raise 'Arg1' if ARGV[0].nil?

input = File.read(ARGV[0]).split.map(&:to_i)

def metas(tree)
  ch, mt = tree.take 2

  pos = 2
  res = nil

  if ch.zero?
    res = tree[pos..-1].take(mt).sum
  else
    childs = Array.new(ch).map do
      child = metas tree[pos..-1]
      pos += child[1]
      child[0]
    end

    res = tree[pos..-1].take(mt).map { |it| childs[it - 1] || 0 }.sum
  end

  [res, pos + mt]
end

puts metas(input).first
