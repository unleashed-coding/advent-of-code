begin
  puts File.readlines(ARGV[0]).reduce(0) { |acc, it| acc + Integer(it) }
rescue TypeError
  puts "Arg1"
rescue => e
  STDERR.puts e
end
