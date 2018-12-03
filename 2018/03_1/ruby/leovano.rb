# frozen_string_literal: true

begin
  input = File.readlines(ARGV[0])

  claims = Hash.new 0

  input.map! do |claim|
    claim.split(/[#@,:x]/)
         .reject(&:empty?)
         .map(&:to_i)
  end

  input.each do |claim|
    (claim[1]...claim[1] + claim[3]).each do |x|
      (claim[2]...claim[2] + claim[4]).each do |y|
        claims[[x, y]] += 1
      end
    end
  end

  puts(claims.values.count { |v| v > 1 })
rescue TypeError
  STDERR.puts 'Arg1'
rescue StandardError => e
  STDERR.puts e
end
