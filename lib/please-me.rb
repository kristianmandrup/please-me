require 'active_support/inflector'
require 'thor'
require 'thor/group'

module Ruby
  class App < ::Thor::Group
    include ::Thor::Actions

    desc "Generates a ruby application"

    # Define arguments and options
    argument :action
    argument :name

    # - please create [name] [--profiles] [--steps] [--user] [--in]
    # - please update [name] [--profiles] [--steps] [--user] [--in]
    # - please remove [name] [--user] [--in]

    class_option :profiles,   :type => :array,   :optional => true,   :desc => "Profiles to use"
    class_option :steps,      :type => :array,   :optional => true,   :desc => "Steps to use"

    class_option :user,       :type => :string,  :optional => true,   :desc => "Use specific user configuration"
    class_option :in,         :type => :string,  :optional => true,   :desc => "Override default destination of thing"    
    class_option :type,       :type => :string,  :optional => true,   :desc => "Type of thing"    
    
    def load_local_settings           
      root_dir = ENV['PLEASE_ME_HOME']      
    end

    def load_config_file       
      config_file = File.join(root_dir, 'config.yml')
      config = YAML.load_file()
    end

    def run                           
      # set destination dir, --in option takes precedence, otherwise use destination for type of thing, as set in config file!
      destination_dir options[:in] || config[:destination][type]
    end

    protected

    attr_accessor :config

    def type
      options[:type]
    end
  
  end
end