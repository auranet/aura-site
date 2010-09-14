class ContactController < ApplicationController
  EMAIL_RE = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  hobo_controller

  def index
    @contact_page = Page.find_by_slug('contact')
    @email = params['email']
    @msg =  params['message']
    if @email
      email_is_valid = @email.match(EMAIL_RE)
    else
      email_is_valid = false
    end

    if verify_recaptcha
      if email_is_valid
        ContactMailer.deliver_email(@email, @msg)
        flash[:notice] = 'Thank you for contacting us!'
        # Clear form
        @email = nil
        @msg = nil
      else
        flash[:error] = 'Your email address was not valid.'
      end
    end
  end
end
