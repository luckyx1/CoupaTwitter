# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      # an image to appear as a red x on github comments
      class Depmodel < Cop

        def has_model? elm
            if ((elm.kind_of?(Array)) && (elm.include? :Base))
                elm.each do |i|
                   if i.class.to_s =~ /Astrolabe/
                        if i.children.include? :ActiveRecord
                           return true
                        else
                            return false
                        end
                   end
                end
            elsif ((elm.kind_of?(Array)) && (elm.include? :ActiveRecord))
                return true
            elsif elm.class.to_s =~ /Astrolabe/
                has_model? elm.children
            else
                return false
            end                     
        end

        def on_class(node)
            _name, _base_class, body = *node
            if has_model?(_base_class)
                 enter_body(node,_name,body.children)
            end 
        end

        def enter_body(node,name, body)
            #body.each{ |i| p "#{i.class} + THIS IS ONE"}
            body.each do |i|
                if i.children.include? :named_scope
                    enter_name_scope(node,name,i.children)
                elsif i.children.include? :default_scope
                    enter_default_scope(node,name,i.children)
                elsif i.children.include? :find_in_batches
                    enter_find_batches(node,name,i.children)
                else
                    
                    # p "this is something else"
                    # p i.children
                end
            end
        end

        def enter_name_scope(node,name,scope)
            #scope.each {|o| p o.children if o.class.to_s =~ /Astrolabe/}
            # node.each_child_node do |child_node|
            #     p child_node
            # end
            # arr = enter_node(scope)
            # bool = false
            # arr.each do |i|
            #     if i.class.to_s =~ /Symbol/
            #         bool = i
            #     end
            # end
            #add_offense(node, :expression, "#{IMG} DEPRECATION WARNING: Replaced name_scope with the following: `scope` :#{bool}") if bool
        end


        def enter_node(elm)
            elm.map {|o| o.children if o.class.to_s =~ /Astrolabe/}.compact.flatten
        end


        def enter_default_scope(node,name,scope)
            #p scope
        end

        def enter_find_batches(node,name,scope)
            # p scope
        end



      end #class end
  	end
  end
end