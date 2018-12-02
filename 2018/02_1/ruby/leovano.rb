# frozen_string_literal: true

begin
  counts = File.readlines(ARGV[0]).map do |word|
    word.chars.group_by(&:itself).transform_values(&:size).invert
  end

  chars_two = counts.count { |c| c[2] }
  chars_three = counts.count { |c| c[3] }

  puts chars_two * chars_three
rescue TypeError
  STDERR.puts 'Arg1'
rescue StandardError => e
  STDERR.puts e
end
