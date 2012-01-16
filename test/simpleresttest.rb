require File.expand_path('../../web/simplerest.rb', __FILE__)

require 'test/unit'
require 'rack/test'

class SimpleRestTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
  def test_default
    get '/'
    assert last_response.ok?
    assert_equal "You've hit this page 1 times!", last_response.body
  end

  def test_api_call
    post '/hello/world', :workspace => 'bobs'
    assert_equal 'Hello Frank!', last_response.body
  end
end