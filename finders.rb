module Finders
  # returns partial match when searched by name
  def find_by_name(search_term)
    @data.select do |item|
      @search_results << item if item["full_name"]&.downcase&.include?(search_term.downcase)
    end
  end

  # returns exact match when searched by email
  def find_by_email(search_term)
    @data.select do |item|
      @search_results << item if item["email"]&.downcase&.match?(/^#{search_term.downcase}$/)
    end
  end

  def return_results
    if @search_results.length > 0
      puts "Search Results #{@search_results}"
      @search_results
    else
      raise ArgumentError, "No Results Found"
    end
  end
end