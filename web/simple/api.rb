
require "PStore"

module Simple
  module Api
    
    filename=NilClass
    
    def self.load()
      Dir[File.join(File.dirname(__FILE__), "./service", "*.rb")].each do |file|
        require file
      end  
      ## create file / data dir
      file = File.join(File.dirname(__FILE__), "../../data/simpleapi.pstore")
      ## create data dir
      filename = file.to_s()
      puts filename
      @store ||= PStore.new(filename)
    end
   
    def self.services
      @@services ||= {}
    end
  
    def self.dbstore()
      return @store  
    end

    def self.register_service(service)
      serviceName = service[:name]
      serviceName = serviceName.gsub(/service/,'') ## add without command at the end
      puts serviceName
      puts service[:name]
      services[service[:name]] = service
      services[serviceName] = service
    end

    def self.serviceCall(service='help', args=[])
      ## look at map
      srv = services[service]
      if(srv)
        instance = srv[:klass].new()
        method = srv[:method]
        m = instance.method(method)
        m.call(args) ## todo look at the return
      else
        'no service available'
        ## todo error response
      end
    end

  end
end

class Simple::Api::BaseService
  
    def self.namespace
      self.to_s.split("::").last.downcase
    end
    def self.method_added(method)
      ## register command
      name = [ self.namespace, method.to_s ].compact.join(":")
      puts name
      Simple::Api.register_service(
        :klass       => self,
        :method      => method,
        :namespace   => self.namespace,
        :name     => name,
      )
    end
    
    def db()
      Simple::Api.dbstore()
    end
end

