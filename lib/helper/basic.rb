module Helper
  module Basic    
    def context_dir
      @context_dir ||= user ? File.join(root_dir, user) : root_dir
    end
  end
end