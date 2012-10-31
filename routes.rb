require 'rubygems'

require 'sinatra'
require 'i18n'
require 'hashie'

# If you're using bundler, you will need to add this
require 'bundler/setup'
require 'active_support/all'

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

get '/en/community' do
  @communities = Dir[File.join(File.dirname(__FILE__), 'communities/*')].map {|f| Community.new(YAML.load_file(f)) }
  erb :"en/community"
end

get '/en/timetable' do
  @sessions = TimetableSession.all
  erb :timetable
end

get '/program.html' do
  erb :program
end

get '/register.html' do
  erb :under_construction
end

get '/sponsor.html' do
  erb :sponsor
end

get '/community' do
  @communities = Dir[File.join(File.dirname(__FILE__), 'communities/*')].map {|f| Community.new(YAML.load_file(f)) }
  erb :community
end

get '/timetable' do
  @sessions = TimetableSession.all
  erb :timetable
end

get '/speakers/:id' do
  @speaker = Speaker.find(params[:id])
  erb :speaker_detail
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
  attr_reader :name, :id

  def initialize(args)
    @name = args["name"]
    @description = args["description"]
    @description_en = args["description_en"]
    @id = @name.gsub(/[^a-z]/i, '')
  end

  def description
    I18n.locale == :en && @description_en || @description
  end
end

class TimetableSession
  attr_reader :time, :speaker_id, :workshop_sessions, :invited, :video
  def self.all
    @sessions ||= YAML.load_file(File.join(File.dirname(__FILE__), "sessions.yml")).map {|a| a.map {|h| TimetableSession.new(h)}}
  end
  def initialize(args)
    @time, @title, @title_en, @speaker_id, @workshop_name, @workshop_name_en, @workshop_sessions, @invited, @video = 
      %w[time title title_en speaker_id workshop_name workshop_name_en workshop_sessions invited video].
        map {|s| args[s]}
  end

  def title
    I18n.locale == :en && @title_en || @title || speaker.title
  end

  def workshop_name
    I18n.locale == :en && @workshop_name_en || @workshop_name
  end

  def speaker
    @speaker = Speaker.find(@speaker_id) unless defined?(@speaker) || !@speaker_id
    @speaker
  end

end

class Speaker
  def self.find(id)
    new(YAML.load_file(File.join(File.dirname(__FILE__), "speakers/#{id}.yml")))
  end

  attr_reader :name, :twitter, :url, :org, :desc, :comment

  def initialize(args)
    %w[name twitter url org title title_en desc comment].each do |s|
      instance_variable_set("@#{s}", args[s.to_sym])
    end
  end

  def title
    I18n.locale == :en && @title_en || @title
  end
end
