#!/usr/bin/env ruby
# encoding: UTF-8

require_relative '../lib/isc'

def show_help(message)
  puts "Error: #{message}"
  puts "Usage: #{File.basename(__FILE__)} [options]"
  puts "  --limit=INTEGER  Number of results between 10 and 10000, default 100"
  exit(1)
end

options = {}
options[:limit] = 100

ARGV.each do |option|
  option = option.split('=')
  case option[0]
  when '--limit'
    options[:limit] = option[1].to_i
  else
    show_help('Unrecognized option')
  end
end

show_help('limit option must to be between 10 and 10000') if options[:limit] > 10000

ISC::Attack.new(options).fetch
