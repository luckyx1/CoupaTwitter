# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      # an image to appear as a red x on github comments
      	class DepRailsEnv < Cop
	 		def on_begin(node)
	        	find_env(node)
	        end

	        def on_send(node)
	        	find_env(node)
	        end

	        def on_class(node)
	        	find_env(node)
	        end

	        def find_env(node)
	        	expressions = *node
	        	expressions.each do |expr|
	               	if ((expr.class.to_s =~ /Astrolabe/) && (expr.children.include? :RAILS_ENV))
		             	add_offense(node, :expression, "#{IMG} DEPRECATION WARNING: Convert RAILS_ENV to Rails.env ")
		            end
              	end
	        end

    	end
    end
  end
end
