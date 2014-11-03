# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      class DynamicFinder < Cop
        #node.loc.expression.source

        def on_send(node)
          _receiver, method_name, *_args = *node
          if ((depricated_method(method_name) && (depricated_condition(method_name))) || (method_name.to_s.include? 'scoped'))
            val = method_name.to_s
            if ((val.include? '_all_') || (val.include? 'scoped_by'))
              msg = '`%s` should be replaced with `where(%s)`. Please use the latter.'
            elsif (val.include? 'initialize')
              msg = '`%s` should be replaced with `find_or_initialize_by(%s)`. Please use the latter.'
            elsif (val.include? 'create')
              msg = '`%s` should be replaced with `find_or_create_by(%s)`. Please use the latter.'
            elsif (val.include? 'last')
              msg = '`%s` should be replaced with `where(%s).last`. Please use the latter.'
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

