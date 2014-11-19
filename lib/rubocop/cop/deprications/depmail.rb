# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      # an image to appear as a red x on github comments
      IMG = '![Please use the latter](https://s3.amazonaws.com/uploads.hipchat.com/2002/1324433/oipBBjO8xGvDZmP/x.png)'
      class Depmail < Cop
        MSG = '`mail(:to => '', :subject => '' , ...)`'
        #find all instances of mailer
        def on_class(node)
          _name, _superclass, body = *node
          if (_superclass != nil) && (_superclass.loc.expression.source.to_s =~ /Mailer/ )
            check_def(node)
          end
        end
        #~~~~~~~~~~~~~~~~~
        # Notifier.deliver_signup_notification(recipient)
        # =>
        # Notifier.signup_notification(recipient).deliver
        #looks for all methods that contain the 'deliver_' and updates for Rails 4.0
        def on_send(node)
          _receiver, method_name, *_args = *node
          #if this is a call from a model/mailer(the current way to verify if coming from mailer)
          if (method_name.to_s =~ /deliver_/) 
            name = _receiver.loc.expression.source.to_s
            if (name && is_capital(name))
              msg = "`#{name}`.#{mail_format(method_name.to_s)}`(..).deliver`"
              add_offense(node, :expression, "#{IMG} DEPRECATION WARNING: Replace #{name}.#{method_name}(..) to: "+ msg)
            end
          elsif (method_name.to_s =~/deliver/)
            name = _receiver.loc.expression.source.to_s
            if (name && is_capital(name))
              add_offense(node, :expression, "#{IMG} DEPRECATION WARNING: It appears you constructed a Mailer and then passed the message. Please make an instance of the model, and then call deliver on it")
            end

            
          # elsif (not name.include? '_create_') && (name.include? 'create_')
          #   #p method_name
          #   receiver = '`'+_receiver.loc.expression.source.to_s+'`'
          #   msg = receiver+ '.'+mail_format(method_name)
          #   add_offense(node, :expression, "Please replace mailer with the following format: "+ msg)
          # elsif name.include? 'deliver'

          end
              
        end

        private

        def is_capital(elm)
          cap = elm.capitalize
          return elm[0] == cap[0]
        end

        #to grab the args correctly
        def mail_format(elm)
          i = elm.index('_')
          return elm[i+1,elm.size]
        end

        #~~~~~
        #this class trys to format your mailer for Rails 4.0 format

        #  class Notifier < ActionMailer::Base
        #   def signup_notification(recipient)
        #     recipients      recipient.email_address_with_name
        #     subject         "New account information"
        #     from            "system@example.com"
        #     sent_on         Time.now
        #     content_type    "multipart/alternative"
        #     body            :account => recipient
        #   end
        # end
        #------------------------------------------- to the following:
        # class Notifier < ActionMailer::Base
        #   def signup_notification(recipient)
        #   @account = recipient
        #   mail(:to => recipient.email_address_with_name, :subject => "New account information", :from => "system@example.com", :date => Time.now)
        #   end
        # end


        #walk through the ast node
        def check_def(node)
          defs =  node.children.compact.select{|n| n.type == :def}
          defs.each do |elm|
            check_begin(elm)
          end       
        end
        # walking through the body
        def check_begin(node)
          elm = node.children.compact.select{|n| n if n.class.to_s =~ /Astrolabe/ }
          elm.each do |i|
            check_send(i) if i.type.to_s == 'begin'
          end
        end

        #the difference happens in the send, so compare details, and return offence if depricated
        def check_send(node)
          body = node.children.compact.select{|n| n.type == :send }
          check = false
          body.each do |r|
            if check_body(r)
              check = true
              break
            end
          end
          add_offense(node, :expression, "#{IMG} DEPRECATION WARNING: Replace your mailer with the following form: "+ MSG) if !check
        end

        #if mail function not found, its an old version
        def check_body(node)
          node.children.compact.include?(:mail)
        end

      end
    end
  end
end