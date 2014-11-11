# encoding: utf-8

module RuboCop
  module Cop
    module Deprecation
      class Rjsdeprication < Cop
        img = '![Please use the latter](https://s3.amazonaws.com/uploads.hipchat.com/2002/863140/7yq7CsQBM13f7qt/4TbKy6xLc.png)'
        MSG = "#{img} The `render :update` has been replaced with `respond_to |format|`." 
        def on_send(node)
          _receiver, method_name, *_args = *node
          if method_name.to_s =~ /render/
            val = _args.last.loc.expression.source.to_s 
            if val =~ /update/
              add_offense(node, :expression, MSG)
            end
          end
        end
      end
    end
  end
end