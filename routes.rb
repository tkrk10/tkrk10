require 'rubygems'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'sinatra'

require 'pry'
require 'pry-nav'
require 'pry-exception_explorer'
require 'pry-stack_explorer'

enable :sessions, :logging

get '/' do
  # haml :index, :format => :html5
  File.read(File.join('public', 'html', 'index.html'))
end
