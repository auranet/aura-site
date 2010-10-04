class Comment < ActiveRecord::Base

  hobo_model # Don't put anything above this
  include Rakismet::Model

  fields do
    body :text, :required, :primary_content => true
    is_public :boolean
    user_ip :string
    timestamps
  end

  belongs_to :user, :creator => true, :accessible => false
  belongs_to :entry, :accessible => true

  before_create :check_for_spam
  after_create :notify_entry_user

  rakismet_attrs :author => proc { user.name },
                 :author_email => proc { user.email_address },
                 :comment_type => 'comment',
                 :content => :body

  def check_for_spam
    #self.is_public = !self.spam?
    true
  end

  def notify_entry_user
    EmmettMailer.deliver_new_comment(self)
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    if self.is_public
      true
    else
      if acting_user.administrator? or user_is? acting_user
        true
      else
        false
      end
    end
  end

end
