module StrongAttributes
  class Proxy < BasicObject
    self.instance_methods.each do |method|
      undef_method method unless method =~ /^__.+__$/
    end

    include Permissible

    def to_s
      return object.to_s if permitted_attributes.permitted? :to_s
      ""
    end

    private
    def initialize object
      @object = object
    end

    @null = Proxy.new(nil)
    def self.null
      @null
    end

    attr_reader :object

    def method_missing(name, *args, &block)
      if permitted_attributes.permitted? [name, *args]
        object.__send__(name, *args, &block)
      elsif permitted_attributes.permittable? [name, *args] # return proxy object
        proxy = object.send(name, *args, &block)
        proxy = Proxy.new(proxy) unless proxy.is_a? ::StrongAttributes::Permissible
        proxy.__send__(:link_permissions, self, [name,*args])
        proxy
      else
        raise NoMethodError unless object.respond_to? name
        Proxy.null
      end
    end
  end
end
