require 'active_support/inflector'
require 'thor'
require 'thor/group'

require 'helper/basic'

module Ruby
  class App < ::Thor::Group
    include ::Thor::Actions

    include Helper::Basic

    desc "Generates a ruby application"

    # Define arguments and options
    argument :command
    argument :name

    # - please create [name] [--profiles] [--steps] [--user] [--in]
    # - please update [name] [--profiles] [--steps] [--user] [--in]
    # - please revert [name] [--user] [--in]
    # 
    # - please install-step [name] [--url] [--user]
    # - please remove-step [name] [--url] [--user]
    # 
    # - please create-user [name]
    # - please remove-user [name]
    # 
    # - please create-profile [name] [--user]
    # - please remove-profile [name] [--user]

    class_option :profiles,   :type => :array,   :optional => true,   :desc => "Profiles to use"
    class_option :steps,      :type => :array,   :optional => true,   :desc => "Steps to use"

    class_option :user,       :type => :string,  :optional => true,   :desc => "Use specific user configuration"
    class_option :in,         :type => :string,  :optional => true,   :desc => "Override default destination of thing"    
    class_option :type,       :type => :string,  :optional => true,   :desc => "Type of thing"    
    
    def load_local_settings           
      root_dir = ENV['PLEASE_ME_HOME']      
    end

    def load_config_file       
      config = YAML.load_file(get_config_file)
    end

    def set_destination                           
      # set destination dir, --in option takes precedence, otherwise use destination for type of thing, as set in config file!
      destination_dir options[:in] || config[:destination][type]
    end

    def execute
      require_command    
      command_class = get_command_class
      command_class.new config, options
      command_class.execute
    end      

    protected

    attr_accessor :config, :target, :command_class

    def get_config_file
      File.join(context_dir, 'config.yml')
    end

    TARGETS = [:step, :user, :profile, :project]

    def set_target
      TARGETS.each do |t|
        target = t if command =~ /#{t}/
      end
      return TARGETS.last if !target
    end


    def require_command
      require_all File.dirname(__FILE__) + "/#{target}/#{command}"      
    end

    def get_command_class name
      command_class = "Command::#{target.camelize}::#{name.camelize}".constantize                  
    end

    def type
      options[:type]
    end
  
  end
end