# frozen_string_literal: true

begin
  input = File.read(ARGV[0]).chomp

  idx = 0
  loop do
    break if idx == input.size - 1

    if input[idx] != input[idx + 1] && input[idx].casecmp(input[idx + 1]).zero?
      input.slice! idx..idx + 1
      idx -= 1
    else
      idx += 1
    end
  end

  puts input
rescue TypeError
  STDERR.puts 'Arg1'
rescue StandardError => e
  STDERR.puts e
end
