require 'sinatra'

$:.unshift File.expand_path('../', __FILE__)

require 'simple/api'
Simple::Api.load()

enable :sessions

before do
  puts 'Security here'
end


get '/' do
  session['counter'] ||= 0
  session['counter'] += 1
  "You've hit this page #{session['counter']} times!"
end


get '/api/:servname/:operation' do
  runMethod(params[:servname], params[:operation],'r',params)
end

put '/api/:servname/:operation' do
  runMethod(params[:servname], params[:operation],'u',params)
end

delete '/api/:servname/:operation' do
  runMethod(params[:servname], params[:operation],'d',params)
end

def runMethod(name, operation,type='r', args=[])
  ## todo make switch statement?
  content_type :json
  ## TODO filter out operation and servname from args
  case type
  ## follows crud
    when 'r':
      operationName = ['read_',operation].compact.join()     
    when 'u':
      operationName = ['update_',operation].compact.join()     
    when 'd':
      operationName = ['delete_',operation].compact.join()     
    else
    ## do nothing    
  end
  
  serviceName = [ name, operationName].compact.join(":")
  return Simple::Api::serviceCall(serviceName, args)
end

after do
  puts response.status
end