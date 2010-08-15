require 'command/project/base'

module Command
  class Initialize << Base
    def initialize config, options = {}
      super
    end
    
    def execute
      create_dir 'please-me-configuration', options[:in] do
        create_dirs :profiles, :steps      
      end
    end    
  end
end