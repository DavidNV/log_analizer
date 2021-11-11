require_relative 'log_analizer.rb'

def pluralize(views)
  views == 1 ? "#{views} visit" : "#{views} visits"
end

def report(data, title)
  puts "==[#{title}]=================="
  data.each do |url, views|
    puts "#{url} #{pluralize(views)}"
  end
  puts "====================================\n"
end

def validate_opts(opt)
  raise "Invalid Opts. Use 'all', 'unique_most_visited' or 'most_visited'" if !['all', 'unique_most_visited', 'most_visited'].include?(opt)
end

file = ARGV[0]
opt = ARGV[1]

begin
  validate_opts(opt)
  lines = File.readlines(file)
  analizer = LogAnalizer.new(lines)

  report(analizer.most_visited_pages, 'Most page views') if ['all', 'most_visited'].include?(opt)
  report(analizer.unique_most_visited_pages, "Most page Unique views") if ['all', 'unique_most_visited_pages'].include?(opt)

rescue Exception => error
  puts "Error #{error.message}"
end
