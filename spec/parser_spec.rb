class Parser;end

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


RSpec.describe Parser do

  describe "#most_visited_pages" do

    context "with no malformed or missing origins" do
      it "should rank ALL visited pages in descendent order" do
      end
    end

    context "with repeated urls and different origins" do
      it "should rank ALL visited pages in descendent order" do
      end
    end

    context "with urls with query strings and different origins" do
      it "should rank ALL visited pages in descendent order" do
      end
    end

    context "with malformed or missing origins" do
      it "should rank the VALID visited pages in descendent order" do
      end
    end

  end

  describe "#unique_most_visited_pages" do

    context "with no malformed or missing origins" do
      it "should rank unique visited pages per origin in descendent order" do
      end
    end

    context "with repeated urls and different origins" do
      it "should rank unique visited pages per origin in descendent order" do
      end
    end

    context "with urls with query strings and different origins" do
      it "should rank unique visited pages in descendent order" do
      end
    end

    context "with malformed or missing origins" do
      it "should rank the UNIQUE VALID visited pages in descendent order" do
      end
    end

  end
end
