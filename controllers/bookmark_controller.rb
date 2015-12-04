get '/bookmark' do
  @bookmarks = Bookmark.all
  erb :'bookmark/index'
end

get '/bookmark/new' do
  erb :'bookmark/new'
end

post '/bookmark' do
  values = {'name' => params['name'], 'url' => params['url'], 'genre' => params['genre']}
  bookmark = Bookmark.new(values)
  bookmark.save
  redirect to('/bookmark')
end

get '/bookmark/:id' do
  @bookmark = Bookmark.find(params['id'])
  erb :'bookmark/show'
end

get '/bookmark/:id/edit' do
  @bookmark = Bookmark.find(params['id'])
  erb :'bookmark/edit'
end

post '/bookmark/:id' do
  bookmark = Bookmark.find(params['id'])

  bookmark.name = params['name']
  bookmark.url = params['url']
  bookmark.genre = params['genre']

  bookmark.save

  redirect to('/bookmark')
end

post '/bookmark/:id/delete' do
  bookmark = Bookmark.find(params['id'])
  bookmark.delete
  redirect to('/bookmark')
end

get '/bookmark/order_by/:group' do
  @bookmarks = Bookmark.all_grouped_by(params['group'])
  erb :'bookmark/index'
end