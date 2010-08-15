require 'command/project/base'

module Command::Project
  class Revert << Base
    def initialize config, options = {}
      super
    end
    
    def execute
      def execute
        create_dir options[:name] do
          get_profiles do |profile|
            profile.get_entries do |entry|
              entry.steps do |steps|
                steps.revert!
              end
            end
          end
        end
    end    
  end
end