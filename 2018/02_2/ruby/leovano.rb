# frozen_string_literal: true

def find_id(words)
  words.combination(2) do |w1, w2|
    diff = w1.chars.zip(w2.chars).select { |cs| cs[0] == cs[1] }
    return diff.map(&:first).join if diff.count == w1.size - 1
  end
end

begin
  puts find_id File.readlines ARGV[0]
rescue TypeError
  STDERR.puts 'Arg1'
rescue StandardError => e
  STDERR.puts e
end
