require 'rubygems'

require 'sinatra'
require 'i18n'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'pry'
require 'pry-nav'
require 'pry-exception_explorer'
require 'pry-stack_explorer'

set :public_folder, File.dirname(__FILE__) + '/static'

I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config', 'locales', '*.yml').to_s]

before do
  I18n.locale = request.path_info =~ %r{^/en} ? :en : :ja
end

get '/' do
  erb :index
end

get '/en' do
  erb :"en/index"
end

get '/program.html' do
  erb :under_construction
end

get '/register.html' do
  erb :under_construction
end

get '/sponsor.html' do
  erb :sponsor
end

get '/community' do
  erb :community
end

get '/favicon.ico' do
  File.read(File.join('static', 'img', 'favicon.ico'))
end

helpers do
  def t(*args)
    I18n.t(*args)
  end
end

