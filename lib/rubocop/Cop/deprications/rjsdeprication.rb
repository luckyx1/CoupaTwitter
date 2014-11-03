# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      class Rjsdeprication < Cop
        MSG = "The `render :update` has been replaced with `respond_to |format|`. Please use the latter"
        def on_send(node)
          _receiver, method_name, *_args = *node
          if method_name.to_s.include? 'render'
            val = _args.last.loc.expression.source.to_s 
            if val.include? 'update'
              add_offense(node, :expression, MSG)
            end
          end
        end
      end
    end
  end
end