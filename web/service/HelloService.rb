require 'baseapi'


class HelloService < Simple::Api::BaseService
  
  def read_world()
    "hello world"  
  end
  
  def update_world()
    "updating hello world"  
  end
  
  def delete_world()
    "deleting hello world"  
  end 
end
