require 'helper/basic'

module Command
  class Base
    include Helper::Basic

    attr_accessor :config, :options
    
    def initialize config, options = {}
      self.config = config
      self.options = options
    end
    
    def execute
      raise "You called Command::Base#execute which must be overridden by subclass"
    end  
    
    protected 
    
    def create_dir name, &block
      empty_directory name
      enter_dir name, &block if block
    end  

    def enter_dir name, &block
      inside name, &block
    end

    def create_dirs *names, &block
      names.each{|name| create_dir name}
      yield if block 
    end
  end
end