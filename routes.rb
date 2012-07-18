require 'rubygems'

require 'sinatra'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'pry'
require 'pry-nav'
require 'pry-exception_explorer'
require 'pry-stack_explorer'

get '/' do
  # haml :index, :format => :html5
  File.read(File.join('public', 'html', 'index.html'))
end

get '/program.html' do
  p 'hoge'
  File.read(File.join('public', 'html', 'program.html'))
end
