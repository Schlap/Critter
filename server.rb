require 'sinatra'
require 'data_mapper'
require 'rack-flash'

env = ENV["RACK_ENV"] || 'development'

DataMapper.setup(:default, "postgres://localhost/critter_#{env}")

require './lib/post.rb'
require './lib/user.rb'

DataMapper.finalize

DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
  @posts = Post.all
  erb :index
end

post '/posts' do
  message = params['message']
  Post.create(:message => message)
  redirect '/'
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
if @user.save
  session[:user_id] = User.id
  redirect to('/')
else
  flash[:notice] = 'Your passwords didn\'t match'
  erb :"users/new"
 end
end

helpers do

  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end

end
