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

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
  def present?
    !blank?
  end
end
class String
  def blank?
    self !~ /[^[:space:]]/
  end
end
class NilClass
  def blank?
    true
  end
end

parent_dir = File.expand_path("../../speakers", __FILE__)
FileUtils.mkdir_p(parent_dir)

speakers = {}

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

  speakers[speaker[:id]] = speaker
end

%w(1st 2nd).each do |day|
  csv_path = File.expand_path("../../tmp/#{day}_day.csv", __FILE__)
  csv_string = File.read(csv_path)
  csv = CSV.new(csv_string, headers: :first_row)

  html_path = File.expand_path("../../tmp/#{day}_day.html", __FILE__)
  html = File.open(html_path, "w")

  html.puts(%Q{<table>})
  csv.each do |row|
    time  = row[0]
    title = row[1]
    id    = row[2]
    span  = row[3]

    name = nil
    if title.blank?
      speaker = speakers[id]
      next if speaker.blank?
      title = speaker[:title]
      name  = speaker[:name]
    end

    html.puts(%Q{<tr>})
    html.puts(%Q{<td class="time">#{time}-#{span}</td>})
    if name.present?
      html.puts(%Q{<td class="name-and-title"><div class="name">#{name}</div><div class="title"><a href="/speakers/#{id}">#{title}</a></div></td>})
    else
      html.puts(%Q{<td class="title-only"><div class="title"><a href="/speakers/#{id}">#{title}</a></div></td>})
    end
    html.puts(%Q{</tr>})
  end
  html.puts(%Q{</table>})

  html.close
end
