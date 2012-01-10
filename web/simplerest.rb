require 'sinatra'
require 'baseapi.rb'


enable :sessions

before do
  puts 'Security here'
end


get '/' do
  session['counter'] ||= 0
  session['counter'] += 1
  "You've hit this page #{session['counter']} times!"
end


get '/api/:name/:operation' do
  runMethod(params[:name], params[:operation],'r')
end

put '/api/:name/:operation' do
  runMethod(params[:name], params[:operation],'u')
end

delete '/api/:name/:operation' do
  runMethod(params[:name], params[:operation],'d')
end


def runMethod(name, operation,type='r', args=[])
  ## todo make switch statement?
  ## follows crud
  if(type == 'r')
    operationName = ['read_',operation].compact.join()     
  elsif(type == 'u')
    operationName = ['update_',operation].compact.join()     
  elsif(type == 'd')
    operationName = ['delete_',operation].compact.join()     
  end
  serviceName = [ name, operationName].compact.join(":")
  Simple::Api::serviceCall(serviceName, args)
end

after do
  puts response.status
end