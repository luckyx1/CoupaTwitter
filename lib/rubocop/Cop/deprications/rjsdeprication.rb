# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      class Rjsdeprication < Cop
        img = '[Please use the latter](http://img3.wikia.nocookie.net/__cb20120514130731/clubpenguin/images/5/5f/Red_X.png)'
        MSG = "The `render :update` has been replaced with `respond_to |format|`." + img
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