 class Yotifier < ActionMailer::Base
  def signup_notification(recipient)
	  @account = recipient
	  mail(:to => recipient.email_address_with_name, :subject => "New account information", :from => "system@example.com", :date => Time.now)
  end
end