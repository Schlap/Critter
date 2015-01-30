require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || 'development'

DataMapper.setup(:default, "postgres://localhost/critter_#{env}")

require './lib/post.rb'

DataMapper.finalize

DataMapper.auto_upgrade!

get '/' do
  @posts = Post.all
  erb :index
end

post '/posts' do
  message = params['message']
  Post.create(:message => message)
  redirect '/'
end
