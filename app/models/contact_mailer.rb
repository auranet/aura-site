class ContactMailer < ActionMailer::Base
  def mail(email, message)
    recipients Aura::CONFIG['contact_emails']
    from email
    subject 'Message from Aura site'
    body message
  end
end
