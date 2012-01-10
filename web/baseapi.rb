

module Simple
  module Api
    Dir[File.join(File.dirname(__FILE__), "/service", "*.rb")].each do |file|
    require file
    end

    def self.services
      @@services ||= {}
    end

    def self.register_service(service)
      serviceName = service[:name]
      serviceName = serviceName.gsub(/service/,'') ## add without command at the end
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
        ## todo error response
      end
    end



    class BaseService
        def self.namespace
          self.to_s.split("::").last.downcase
        end
        def self.method_added(method)
          ## register command
          name = [ self.namespace, method.to_s ].compact.join(":")
          Simple::Api.register_service(
            :klass       => self,
            :method      => method,
            :namespace   => self.namespace,
            :name     => name,
          )
        end
    end
    
    
    
  end
end
