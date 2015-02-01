class Post

  include DataMapper::Resource

  property :id,       Serial
  property :message,  String, :required => true, :length => 144

end
