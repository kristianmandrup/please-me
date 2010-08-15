module Step
  class Node
    
    def initialize
    end
    
    def load
      require file_location
      get_const.new config, options
    end
    
    def get_const
      begin
        clazz = "#{node}::#{entry}"
        clazz.constantize
      rescue
        warning "Missing class #{clazz} in file #{file_location}"
      end      
    end
  end
end