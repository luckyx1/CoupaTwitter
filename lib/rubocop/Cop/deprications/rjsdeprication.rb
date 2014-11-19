# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      class Rjsdeprication < Cop
        img = '![Please use the latter](https://s3.amazonaws.com/uploads.hipchat.com/2002/1324433/oipBBjO8xGvDZmP/x.png)'
        MSG = "#{img} `DEPRECATION WARNING: RJS is no longer supported.` Replace `render :update` with `respond_to do |format|`." 
        def on_send(node)
          _receiver, method_name, *_args = *node
          if method_name.to_s =~ /render/
            return if ((_args.empty?) || (_args.last == nil))
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

