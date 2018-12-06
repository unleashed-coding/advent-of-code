# frozen_string_literal: true

begin
  input = File.read(ARGV[0]).chomp

  less = Float::INFINITY
  input.downcase.chars.uniq.each do |c|
    inputf = input.delete c + c.upcase

    idx = 0
    loop do
      break if idx == inputf.size - 1

      if inputf[idx] != inputf[idx + 1] &&
         inputf[idx].casecmp(inputf[idx + 1]).zero?
        inputf.slice! idx..idx + 1
        idx -= 1 if idx.positive?
      else
        idx += 1
      end
    end

    less = inputf.size if inputf.size < less
  end

  puts less
rescue TypeError
  STDERR.puts 'Arg1'
rescue StandardError => e
  STDERR.puts e
end
