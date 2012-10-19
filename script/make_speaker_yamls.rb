#!/usr/bin/env ruby
# coding: utf-8

require "yaml"
require "fileutils"

if RUBY_VERSION > "1.9"
  require "csv"
else
  begin
    require "rubygems"
    require "fastercsv"
    CSV = FasterCSV
  rescue LoadError
    abort "Please install fastercsv gem."
  end
end

parent_dir = File.expand_path("../../speakers", __FILE__)
FileUtils.mkdir_p(parent_dir)

csv_path = File.expand_path("../../tmp/proposal_list.csv", __FILE__)
csv_string = File.read(csv_path)
csv = CSV.new(csv_string, headers: :first_row) 
csv.each do |row|
  next unless row[13] == "◯"

  speaker = {
    id:       row[0], 
    name:     row[1],
    twitter:  row[6], 
    url:      row[7], 
    org:      row[9], 
    title:    row[10], 
    desc:     row[11], 
    comment:  row[12], 
  }

  yaml_path = File.join(parent_dir, "#{speaker[:id]}.yml")
  File.write(yaml_path, speaker.to_yaml)
end

