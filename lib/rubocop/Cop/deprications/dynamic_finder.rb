# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
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
          if ((depricated_method(method_name) && (depricated_condition(method_name))) || (method_name.to_s.include? 'scoped') || (method_name.to_s.include? 'find_by'))
            val = method_name.to_s
            img = '![Please use the latter](https://s3.amazonaws.com/uploads.hipchat.com/2002/863140/7yq7CsQBM13f7qt/4TbKy6xLc.png)'
            if ((val.include? '_all_') || (val.include? 'scoped_by'))
              msg = '`%s` should be replaced with `where(%s)`.'+ img
            elsif (val.include? 'initialize')
              msg = '`%s` should be replaced with `find_or_initialize_by(%s)`.'+ img
            elsif (val.include? 'create')
              msg = '`%s` should be replaced with `find_or_create_by(%s)`.' + img
            elsif (val.include? 'last')
              msg = '`%s` should be replaced with `where(%s).last`.' + img
            elsif val.include? 'find_by'
              msg = '`%s` should be replaced with `where(%s).first`.' + img
            end
            add_offense(node,:expression,format(msg, method_name, format_elm(method_name)))
          end             
        end
          

        def depricated_method(elm)
          val = elm.to_s
          return val.include? 'find' 
        end

        def depricated_condition(elm)
          val = elm.to_s
          return ((val.include? '_all_') || (val.include? '_or_') || (val.include? 'last'))
        end

        def format_elm(elm)
          val = elm.to_s
          i = val.index('by')
          return val[i+3,val.size]
        end
      end
    end
  end
end

