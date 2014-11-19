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
            img = '![Please use the latter](https://s3.amazonaws.com/uploads.hipchat.com/2002/1324433/oipBBjO8xGvDZmP/x.png)'
            warning_msg = 'DEPRECATION WARNING: Dynamic finders are deprecated in Rails >= 4.0.'
            val = method_name.to_s
            case val
               when /all/ 
                 msg = "#{img} #{warning_msg} Replace `%s` with `where(%s: ...)`. " 
               when /initialize/
                 msg = "#{img} #{warning_msg} Replace `%s` with `find_or_initialize_by(%s :...)`. "
               when /create/
                 msg = "#{img} #{warning_msg} Replace `%s` with `find_or_create_by(%s : ...)`. "
               when /last/
                 msg = "#{img} #{warning_msg} Replace `%s` with `where(%s: ...).last`. "
               when /find_by/
                msg = "#{img} #{warning_msg} Replace `%s` with `where(%s: ...).first`. "
               when /scoped_by/
                  msg = "#{img} #{warning_msg} Replace `%s` with `where(%s: ...)`. "
            end
            add_offense(node,:expression,format(msg, method_name, format_elm(method_name)))
          end             
        end
          

        def depricated_method(elm)
          return (((elm.to_s =~ /find/) && (elm.to_s =~ /by/))||  (elm.to_s =~ /scoped_by/))
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
