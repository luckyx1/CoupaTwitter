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
            img = '[Please use the latter](http://img3.wikia.nocookie.net/__cb20120514130731/clubpenguin/images/5/5f/Red_X.png)'
            if ((val.include? '_all_') || (val.include? 'scoped_by'))
              msg = '`%s` should be replaced with `where(%s)`.'+ img
            elsif (val.include? 'initialize')
              msg = '`%s` should be replaced with `find_or_initialize_by(%s)`.'+ img
            elsif (val.include? 'create')
              msg = '`%s` should be replaced with `find_or_create_by(%s)`.' + img
            elsif (val.include? 'last')
              msg = '`%s` should be replaced with `where(%s).last`.' + img
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

