# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      # an image to appear as a red x on github comments
      	class Deplogger < Cop
	        def on_begin(node)
	        	find_log(node)
	        end

	        def on_send(node)
	        	find_log(node)
	        end

	        def on_class(node)
	        	find_log(node)
	        end

	        def find_log(node)
	        	expressions = *node
	        	expressions.each do |expr|
	               	if ((expr.class.to_s =~ /Astrolabe/) && (expr.children.include? :RAILS_DEFAULT_LOGGER))
		             	add_offense(node, :expression, "#{IMG} DEPRECATION WARNING: Convert RAILS_DEFAULT_LOGGER to Rails.logger ")
		            end
              	end
	        end

    	end
    end
  end
end
