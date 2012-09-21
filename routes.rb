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
  @communities = Dir[File.join(File.dirname(__FILE__), 'communities/*')].map {|f| Community.new(YAML.load_file(f)) }
  @english_communities = @communities.find_all {|c| c.description_en }
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

class Community
  attr_reader :name, :description, :description_en, :id

  def initialize(args)
    @name = args["name"]
    @description = args["description"]
    @description_en = args["description_en"]
    @id = @name.gsub(/[^a-z ]/i, '')
  end
end
