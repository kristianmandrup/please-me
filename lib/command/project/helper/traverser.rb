module Profile
  module Traverser
    def traverse(obj, &blk)
      case obj
      when Hash
        handle_hash(obj, &blk)
      when Array
        handle_list(obj, &blk)
      else
        handle_single(obj, &blk)
      end
    end
    
    def handle_hash(obj, &blk)
      # Forget keys because I don't know what to do with them
      obj.each do |dir_name, dir_content|
        blk.call(create_directory dir_name)
        traverse(dir_content, &blk)
        leave_dir      
      end
    end

    def handle_list(obj, &blk)
      obj.each do |dir_content| 
        traverse(dir_content, &blk)
      end
    end

    def handle_single(obj, &blk)
      if obj
        return if parse_meta(obj)                          
        file_name = obj                          
        if ref?(obj)                      
          blk.call(create_symbolic_link ref_name(obj), name(obj))
          return                     
        end        
        name = name(obj)
        if alias?(obj)                      
          create_reference alias_name(obj), name
        end
        handle_single_entry(name, &blk)                                       
      end
    end

    def handle_single_entry(file_name, &blk) 
      if enforce_dir? file_name
        dir_name = file_name.gsub( /\s#{DIR}\s/, '').strip
        blk.call(create_directory dir_name)
        leave_dir      
      else                
        blk.call(create_file file_name)          
      end
    end              
  end
end