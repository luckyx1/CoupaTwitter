# encoding: utf-8

module RuboCop
  module Cop
    module Deprications
      # an image to appear as a red x on github comments
      img = '[Please use the latter](http://img3.wikia.nocookie.net/__cb20120514130731/clubpenguin/images/5/5f/Red_X.png)'
      class Depmail < Cop
        #this class trys to format your mailer to go from the top ... 

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
        MSG = '`mail(:to => '', :subject => '' , ...)` instead'

        #find all instances of mailer
        def on_class(node)
          _name, _superclass, body = *node
          if _superclass.loc.expression.source.to_s.include? 'Mailer'
            check_def(node)
          end
        end

        private

        #walk through the ast node
        def check_def(node)
          defs =  node.children.compact.select{|n| n.type == :def}
          defs.each do |elm|
            check_begin(elm)
          end       
        end
        # walking through the body
        def check_begin(node)
          elm = node.children.compact.select{|n| n if n.class.to_s.include? 'Astrolabe' }
          elm.each do |i|
            check_send(i) if i.type.to_s == 'begin'
          end
        end

        #the difference happens in the send, so compare details, and return offence if depricated
        def check_send(node)
          body = node.children.compact.select{|n| n.type == :send }
          check = false
          body.each do |r|
            check = check_body(r)
          end
          if check
            add_offense(node, :expression, "Please replace mailer with the following format: "+ MSG)
          end
          #add_offense(_body, :name, message(method_name, m_args))
        end

        #if mail function not found, its an old version
        def check_body(node)
          node.children.compact.each do|i|
            if i.class == Symbol && i != :mail
              return true
            end
          end
          false
        end

        def message(class_name, method_name)
          format(MSG, method_name, class_name, method_name)
        end     

      end
    end
  end
end