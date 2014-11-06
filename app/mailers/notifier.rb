class Notifier < ActionMailer::Base
    def signup_notification(recipient, taco)
      recipients      recipient.email_address_with_name
      subject         "New account information"
      from            "system@example.com"
      sent_on         Time.now
      content_type    "multipart/alternative"
      body            :account => recipient
    end
  end