# frozen_string_literal: true

begin
  counts = File.readlines(ARGV[0]).map do |word|
    word.chars.group_by(&:itself).transform_values(&:size).invert
  end

  chars_two = counts.select { |c| c[2] }.size
  chars_three = counts.select { |c| c[3] }.size

  puts chars_two * chars_three
rescue TypeError
  STDERR.puts 'Arg1'
rescue StandardError => e
  STDERR.puts e
end
