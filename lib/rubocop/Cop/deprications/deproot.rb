# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      # an image to appear as a red x on github comments
      	class Deproot < Cop
	        def on_begin(node)
	        	find_root(node)
	        end

	        def on_send(node)
	        	find_root(node)
	        end

	        def on_class(node)
	        	find_root(node)
	        end

	        def find_root(node)
	        	expressions= *node
	        	expressions.each do |expr|
	               	if ((expr.class.to_s =~ /Astrolabe/) && (expr.children.include? :RAILS_ROOT))
	               		a,b= *node
	               		msg=""
	               		case(b)
	               			when :join
	               				msg="Covert .join(RAILS_ROOT, ..) to Rails.root.join(...)"
	               			when :+
	               				msg="Convert RAILS_ROOT + ... to Rails.root.join(..)"
	               			else
	               				msg="Convert RAILS_ROOT to Rails.root "
	               			end
		             	add_offense(node, :expression, "#{IMG} DEPRECATION WARNING: #{msg} ")
		            end
              	end
	        end
    	end
    end
  end
end
