# frozen_string_literal: true

require 'set'

begin
  oscs = File.readlines(ARGV[0]).map { |it| Integer(it) }

  freq = 0
  oset = Set[]

  oscs.cycle.each do |n|
    freq += n
    if oset.include? freq
      puts freq
      break
    else
      oset.add freq
    end
  end
rescue TypeError
  STDERR.puts 'Arg1'
rescue StandardError => e
  STDERR.puts e
end
