class Entry < ActiveRecord::Base
  hobo_model # Don't put anything above this

  before_save :process_markdown, :save_tags

  fields do
    name          :string
    body_markdown :text
    body_html     :html
    tagstring     :string
    timestamps
  end

  belongs_to :user, :creator => true
  has_many :tags, :through => :tag_assignments, :accessible => true
  has_many :tag_assignments, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  set_default_order "created_at desc"
  set_search_columns :name, :body_html

  named_scope :viewable, lambda {|acting_user| {
    :conditions =>
      "#{acting_user.administrator? ? 1 : 0}=1 OR state='published'"
  }}


  lifecycle do
    state :drafted, :default => true
    state :published

    transition :publish, {:drafted => :published}, :available_to => :user
    transition :unpublish, {:published => :drafted}, :available_to => :user
  end

  def process_markdown
    if not self.body_markdown.blank?
      self.body_html = Maruku.new(self.body_markdown).to_html
    end
  end

  def save_tags
    new_tags = tagstring.split(',').collect{ |name|
      Tag.find_or_create_by_name(name.strip)
    }
    self.tags.each{ |tag|
      if !new_tags.include?(tag)
        self.tags.delete(tag)
      end
    }
    self.tags = new_tags
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    acting_user.administrator? or state == 'published'
  end

end
