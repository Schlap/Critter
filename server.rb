require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || 'development'

DataMapper.setup(:default, "postgres://localhost/critter_#{env}")

require './lib/post.rb'
require './lib/tag.rb'

DataMapper.finalize

DataMapper.auto_upgrade!

get '/' do
  @posts = Post.all
  erb :index
end

post '/posts' do
  message = params['message']
  tags = params['tags'].split(' ').map do |tag|
  Tag.first_or_create(:text => tag)
end
  Post.create(:message => message, :tags => tags)
  redirect '/'
end
