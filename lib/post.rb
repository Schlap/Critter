class Post

  include DataMapper::Resource

  property :id,       Serial
  property :message,  String

end