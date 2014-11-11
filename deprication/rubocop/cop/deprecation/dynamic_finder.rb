# encoding: utf-8
module RuboCop
  module Cop
    module Deprecation
      class DynamicFinder < Cop
        #this cop looks for the following deprications:    
          #find_all_by_... => where(...)
          #find_by_... => where(...).first
          #find_last_by_... => where(...).last
          #scoped_by_... => where(...)
          #find_or_initialize_by_... => find_or_initialize_by(...)
          #find_or_create_by_... => find_or_create_by(...)

        def on_send(node)
          _receiver, method_name, *_args = *node
          if depricated_method(method_name)
            img = '![Please use the latter](https://s3.amazonaws.com/uploads.hipchat.com/2002/863140/7yq7CsQBM13f7qt/4TbKy6xLc.png)'
            val = method_name.to_s
            case val
               when /all/ 
                 msg = "#{img} `%s` should be replaced with `where(%s: ...)`. " 
               when /initialize/
                 msg = "#{img} `%s` should be replaced with `find_or_initialize_by(%s :...)`. "
               when /create/
                 msg = "#{img} `%s` should be replaced with `find_or_create_by(%s : ...)`. "
               when /last/
                 msg = "#{img} `%s` should be replaced with `where(%s: ...).last`. "
               when /find_by/
                msg = "#{img} `%s` should be replaced with `where(%s: ...).first`. "
               when /scoped_by/
                  msg = "#{img} `%s` should be replaced with `where(%s: ...)`. "
            end
            add_offense(node,:expression,format(msg, method_name, format_elm(method_name)))
          end             
        end
          

        def depricated_method(elm)
          return (elm.to_s =~ /find/) ||  (elm.to_s =~ /scope/)
        end

        def format_elm(elm)
          begin
            val = elm.to_s
            i = val.index('by')
            return val[i+3,val.size]
          rescue
            #couldn't parse, so return what was passed in
            return elm
          end
        end
      end
    end
  end
end
