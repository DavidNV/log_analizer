require_relative './../log_analizer.rb'

=begin
  Parser Rules

  1. List webpages ordered by number of views
  2. List webpages ordered by unique number of views

  Asumptions

  - The log file contains could contain different kind of lines
  - A valid line should be composed by at least two values: URL and Origin
  - If a line contains a more than these two values, the extra values will be ignored
  - If a line contains just the url and no origin:
    * For most visited pages, each ocurrence will be counted
    * For unique most visited pages, it will add one extra view to the count since we know for sure at least one time the url was accessed
  - If the url contains query strings it will be treated as a unique url.
  - If the origin is malformed the line will be ignored.
=end


RSpec.describe LogAnalizer do
  shared_context "valid_lines_with_different_origins_and_query_strings" do
    let(:valid_lines) do
      [ 
        "/index/ 316.433.849.805",
        "/index/ 316.433.849.805",
        "/index/2 43.10.44.29",
        "/index/2 316.433.849.805",
        "/valid_test?extra=1 316.433.849.805",
        "/valid_test?extra=1 316.433.849.805",
        "/valid_test?extra=1 44.43.84.85",
        "/valid_test?extra=2 16.433.849.805",
        "/about/ 316.433.849.805",
        "/about/2 43.10.44.29",
        "/about/2 316.433.849.805",
        "/about/2 43.10.44.29",
        "/about/2 43.10.44.29",
        "/about/2 43.10.44.29",
        "/about/2 316.433.849.805",
        "/about/2 316.433.849.805",
      ]
    end
  end

  shared_context "valid_and_invalid_lines_with_different_origins_and_query_strings" do
    let(:valid_and_invalid_lines) do
      [ 
        "/index/ 316.433.849.805",
        "/index/ 316.433.849.805",             # duplicated origin
        "/index/ ddd.433.849.805",             # malformed origin
        "/index/2 43.10.44.29",
        "/index/2 316.433.849.805",
        "/valid_test?extra=1 316.433.849.805",
        "/valid_test?extra=1 316.433.849.805", # duplicated origin
        "/valid_test?extra=2 ",                # missing origin
        "/valid_test?extra=2 316.433.849.805",
        "/about/ 316.433.849.805",
        "/about/2 43.10.44.29",
        "/about/2 11.12.44.59",
        "/about/2 316.433.849.805",            # duplicated origins
        "/about/2 43.10.44.29",
        "/about/2 43.10.44.29",
        "/about/2 316.433.849.805",
        "/about/2 316.433.849.805",
      ]
    end
  end

  describe "#most_visited_pages" do

    context "with valid lines parsed from log file" do
      include_context 'valid_lines_with_different_origins_and_query_strings'

      context "with no malformed or missing origins, repeated urls, with urls with querystrings and different origins" do
        it "should rank ALL visited pages in descendent order" do
          expected_result = {
            "/index/": 2,
            "/index/2": 2,
            "/valid_test?extra=1": 3,
            "/valid_test?extra=2": 1,
            "/about/": 1,
            "/about/2": 7,
          }
          result = LogAnalizer.new(valid_lines).most_visited_pages
          expect(result).to match(expected_result)
        end
      end

    end

    context "with not good lines from log file" do
      include_context 'valid_and_invalid_lines_with_different_origins_and_query_strings'

      context "with malformed or missing origins" do
        it "should rank the VALID visited pages in descendent order" do
          expected_result = {
            "/index/": 1,
            "/index/2": 2,
            "/valid_test?extra=1": 1,
            "/valid_test?extra=2": 1,
            "/about/": 1,
            "/about/2": 3,
          }
          result = LogAnalizer.new(valid_and_invalid_lines).most_visited_pages
          expect(result).to match(expected_result)
        end
      end
    end

  end

  describe "#unique_most_visited_pages" do

    context "with valid lines parsed from log file" do
      include_context 'valid_lines_with_different_origins_and_query_strings'

      context "with no malformed or missing origins, repeated urls, with urls with querystrings and different origins" do
        it "should rank unique visited pages per origin in descendent order" do
          expected_result = {
            "/index/": 1,
            "/index/2": 2,
            "/valid_test?extra=1": 2,
            "/valid_test?extra=2": 1,
            "/about/": 1,
            "/about/2": 2,
          }
          result = LogAnalizer.new(valid_lines).unique_most_visited_pages
          expect(result).to match(expected_result)
        end
      end

    end

    context "with not good lines from log file" do
      include_context 'valid_and_invalid_lines_with_different_origins_and_query_strings'

      context "with malformed or missing origins" do
        it "should rank the UNIQUE VALID visited pages in descendent order" do
          expected_result = {
            "/index/": 1,
            "/index/2": 2,
            "/valid_test?extra=1": 1,
            "/valid_test?extra=2": 1,
            "/about/": 1,
            "/about/2": 3,
          }
          result = LogAnalizer.new(valid_and_invalid_lines).unique_most_visited_pages
          expect(result).to match(expected_result)
        end
      end

    end
  end
end
