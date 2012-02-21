require "simple/api"
require "json"

class Simple::Api::HelloService < Simple::Api::BaseService
  
  def read_world(args=[])
    ## doesn't like this
    world = :world
    if(world) 
      store = db()
      store.transaction do
      world = store[world] ##or raise "World not found"
      end 
    end
    if(world)
      world.to_json()
    else 
      "hello world ".concat(args.to_s())
    end
    
  end
  
  def update_world(args=[])
    store = db()
    store.transaction do
    store[:world] ||= []
    store[:world] << args.to_s()
    end
  end
  
  def delete_world(args=[])
    "deleting hello world ".concat(args.to_s())  
  end 
end
