class Post

  include DataMapper::Resource

  has n, :tags, :through => Resource
  property :id,       Serial
  property :message,  String

end
