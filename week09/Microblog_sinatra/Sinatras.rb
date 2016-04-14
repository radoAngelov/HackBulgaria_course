require "sinatra"

$POSTS = []
$TAGS = {}

class Post
  attr_reader :id, :content

  def initialize(id, content)
    @id = id
    @content = content
  end

  def extract_tags
    tag_arr = content.split("#")
    tag_arr = tag_arr.drop(1)
    $TAGS[id] = tag_arr
  end
end

get '/' do
  if $POSTS.size != 0
    $POSTS.map(&:content).join("<br>")
  else
    "NO POSTS YET"
  end
end

get '/new' do
  erb :style
end

get '/new/' do
  erb :style
end

post '/new' do
  if params[:content].size < 257
    $POSTS << Post.new(params[:id], params[:content])
    redirect '/'
  else
    redirect'/new'
  end
end

get '/:id' do
  post = $POSTS.find { |address| address.id == params[:id] }
  if post 
    post.content
  else
    "NO POST WITH SUCH ID"
  end
end

get '/delete/:id' do
  erb :delete, locals:{id:params[:id]}
end

delete '/:id' do
  $POSTS.reject! { |address| address.id == params[:id] }
  redirect '/'
end

get '/search/:tag' do
  $POSTS.each { |post| post.extract_tags }
  posts_with_tags = []
  $TAGS.each_pair do |key, val|
    if val.find { |e| e.to_s == params[:tag] }
      posts_with_tags << key
    else
      "NO POST WITH THAT TAG"
    end
  end
  posts_with_tags.join("<br>")
end