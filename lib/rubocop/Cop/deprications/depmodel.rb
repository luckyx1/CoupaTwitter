# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      # an image to appear as a red x on github comments
      class Depmodel < Cop
      	  def on_class(node)
         	_name, _base_class, body = *node
         	def has_model? elm
         		if elm.kind_of?(Array)
         			if elm.include? :Base
         				elm.each do |i|
         					if i.class.to_s =~ /Astrolabe/
         						has_model? i.children
         					end
         				end
         			elsif elm.include? :ActiveRecord
         				return true 
         			else
			   			return false
			   		end
         		elsif elm.class.to_s =~ /Astrolabe/
         			has_model? elm.children
         		else
         			false
         		end     				
         	end 

         	 if has_model?(_base_class)
         	 	p 'start'
         	 	p _name
         	 	p _base_class
         	 	p 'end'
         	 end


         	


         	
        end

      end
  	end
  end
end