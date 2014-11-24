# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      # an image to appear as a red x on github comments
      class Deproute < Cop
      		# def on_begin(node)
	    	#  	find_root(node)
	    	#  end

	    	# def on_send(node)
	        # 	find_root(node)
	        # end

	    	def on_block(node)
	       		find_root(node)
	    	end

	    	def enter_node(elm)
           		elm.map {|o| o.children if o.class.to_s =~ /Astrolabe/}.compact.flatten
        	end

	        def find_root(node)
	        	expressions= *node
	        	expressions.compact.each do |expr|
	               	if expr.type == :block 
	               		map_choice(node, enter_node(expr.children))
	               	end
              	end
	        end

	        def map_choice(node, elm)
	        	p elm.class
	        end
      end
    end
  end
end