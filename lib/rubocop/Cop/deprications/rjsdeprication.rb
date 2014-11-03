# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      class Rjsdeprication < Cop
        #node.loc.expression.source

        def on_send(node)
          _receiver, method_name, *_args = *node
          if method_name.to_s.include? 'render'
            #p arg.last.loc.expression
            msg = "caught"
            add_offense(node, :expression, msg)
          end
        end
      end
    end
  end
end