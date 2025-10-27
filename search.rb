#!/usr/bin/env ruby

require 'httparty'
require 'json'
require 'optparse'
require_relative './lib/finders.rb'
include Finders

response = HTTParty.get("https://appassets02.shiftcare.com/manual/clients.json")

@data = JSON.parse(response.body)
@search_results = []

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
