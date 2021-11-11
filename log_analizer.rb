require_relative 'domain.rb'

class LogAnalizer

  attr_reader :lines

  def initialize(lines)
    @lines = lines
    @lines_parsed = Hash.new { |hash, key| hash[key] = [] }
    validate_and_group_lines_by_url
  end

  def most_visited_pages
    @lines_parsed.each_with_object({}) do |(url, domains), hash|
      total_views = domains.count
      hash[url.to_sym] = total_views
    end.sort_by { |_url, views| views }.reverse.to_h
  end

  def unique_most_visited_pages
    @lines_parsed.each_with_object({}) do |(url, domains), hash|
      total_unique_views =  domains.uniq.count
      hash[url.to_sym] = total_unique_views
    end.sort_by { |_url, views| views }.reverse.to_h
  end

  private

  def validate_and_group_lines_by_url
    lines.each do |line|

      line_parsed = line.gsub("\n", "").scan(/([^\s]+)/).flatten
      domain = line_parsed[1]
      next unless Domain.new(domain).valid?
      url = line_parsed[0]

      @lines_parsed[url] << domain
    end
  end

end
