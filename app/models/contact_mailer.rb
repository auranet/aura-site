class ContactMailer < ActionMailer::Base
  def email(from_email, message)
    recipients Aura::CONFIG['contact_emails']
    from from_email
    subject 'Message from Aura site'
    body message
  end
end
