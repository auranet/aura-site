class EmmettMailer < ActionMailer::Base
  def new_comment(comment)
    @from = Aura::CONFIG["from_email"]
    @recipients = comment.entry.user.email_address
    @subject = "New comment on #{comment.entry.name}"
    @body[:comment] = comment
    @content_type = "text/html"
  end
end
