require 'sinatra'

before do
  puts 'Security here'
end


get '/' do
  'Hello world!'
  
end


get '/hello/:name' do
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params[:name] is 'foo' or 'bar'
  "Hello #{params[:name]}!"
end

get '/params/:name' do |n|
  "Hello #{params[:name]} - #{n}!"
end


after do
  puts response.status
end