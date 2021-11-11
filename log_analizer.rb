class LogAnalizer

  attr_reader :lines

  def initialize(lines)
    @lines = lines
    @lines_parsed = Hash.new { |hash, key| hash[key] = [] }
  end

  def most_visited_pages
  end

  def unique_most_visited_pages
  end

  private

  def validate_and_group_lines_by_url
    lines.each do |line|
      # match have two groups, url and domain
      line_parsed = line.gsub("\n", "").scan(/([^\s]+)/).flatten
      @lines_parsed[line_parsed[0]] << line_parsed[1]
    end
  end

end
