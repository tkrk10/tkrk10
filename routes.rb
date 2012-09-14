require 'rubygems'

require 'sinatra'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'pry'
require 'pry-nav'
require 'pry-exception_explorer'
require 'pry-stack_explorer'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  # haml :index, :format => :html5
  File.read(File.join('static', 'html', 'index.html'))
end

get '/en' do
  File.read(File.join('static', 'html', 'en', 'index.html'))
end

get '/program.html' do
  File.read(File.join('static', 'html', 'underConstraction.html'))
end

get '/register.html' do
  # File.read(File.join('static', 'html', 'register.html'))
  File.read(File.join('static', 'html', 'underConstraction.html'))
end

get '/sponsor.html' do
  File.read(File.join('static', 'html', 'sponsor.html'))
end

get '/community' do
  File.read(File.join('static', 'html', 'community', 'index.html'))
end

get '/community/shibuya_rb.html' do
  File.read(File.join('static', 'html', 'community', 'shibuya_rb.html'))
end

get '/community/shinjuku_rb.html' do
  File.read(File.join('static', 'html', 'community', 'shinjuku_rb.html'))
end

get '/community/tokyu_rb.html' do
  File.read(File.join('static', 'html', 'community', 'tokyu_rb.html'))
end

get '/community/minami_rb.html' do
  File.read(File.join('static', 'html', 'community', 'minami_rb.html'))
end

get '/community/rubykaja.html' do
  File.read(File.join('static', 'html', 'community', 'rubykaja.html'))
end

get '/favicon.ico' do
  File.read(File.join('static', 'img', 'favicon.ico'))
end
