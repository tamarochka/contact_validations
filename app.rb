require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/reloader'

require 'pry'

configure do
  enable :sessions
  set :views, 'app/views'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

get '/' do
  @contacts = Contact.alphabetically
  erb :index
end

get '/contacts/new' do
  @contact = Contact.new

  erb :'contacts/new'
end

post '/contacts' do
  @contact = Contact.new(params[:contact])

  if @contact.save
    flash[:notice] = 'Contact created successfully!'
    redirect '/'
  else
    flash.now[:error] = 'There were some errors the provided information.'
    erb :'contacts/new'
  end
end
