#!/usr/bin/env ruby

require 'httparty'
require 'json'
require 'optparse'

response = HTTParty.get("https://appassets02.shiftcare.com/manual/clients.json")

@data = JSON.parse(response.body)
@search_results = []

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

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ./search.rb [options]"

  opts.on("-n NAME", "--name NAME", "Search by name") do |name|
    options[:name] = name
  end

  opts.on("-e", "--email EMAIL", "Search by email") do |email|
    options[:email] = email
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

if options[:name]
  find_by_name(options[:name])
  return_results
end

if options[:email]
  find_by_email(options[:email])
  return_results
end
