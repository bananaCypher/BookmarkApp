require 'sinatra'
require 'sinatra/contrib/all' if development?
require 'pg'

require_relative 'controllers/bookmark_controller'
require_relative 'models/bookmark'

get '/' do
  erb :home
end