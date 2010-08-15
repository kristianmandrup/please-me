module Command
  module Project
    class Base << Command::Base
      def initialize config, options = {}
        super
      end
    
      def execute
        super
      end    
      
      protected

      # REFACTOR!
      
      def execute_profile name, entry_name
        profile = YAML.load_file get_profile(name)        
        profile_entry = profile[entry_name]        

        traverser = FileSystem::Traverser.new root_dir, options

        traverser.traverse(profile_entry) do |step_node|
          step_node.execute
        end
      end

      def get_steps_dir
        File.join(context_dir, 'steps', "#{name}.yml")                
      end
      
      def get_profile name
        File.join(context_dir, 'profiles', "#{name}.yml")
      end
    end
  end
end