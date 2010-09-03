class Page < ActiveRecord::Base
  hobo_model # Don't put anything above this

  before_create :make_slug
  before_save :process_markdown
  after_save :adjust_front_page

  fields do
    name          :string
    slug          :string, :unique
    body_markdown :text
    body_html     :raw_html
    is_front_page :boolean
    is_erb        :boolean, :default => false
    timestamps
  end

  set_search_columns :name, :body_html

  named_scope :viewable, lambda {|acting_user| {
    :conditions =>
      "#{acting_user.administrator? ? 1 : 0}=1 OR state='published'"
  }}

  lifecycle do
    state :drafted, :default => true
    state :published

    User.find(:all, :conditions => {:administrator => true})

    transition :publish, {:drafted => :published},
      :available_to => lambda {administrators}
    transition :unpublish, {:published => :drafted},
      :available_to => lambda {administrators}
  end

  def administrators
    User.find(:all, :conditions => {:administrator => true})
  end

  def make_slug
    if slug.blank?
      self.slug = slugify(name)
    end
  end

  def process_markdown
    if not self.body_markdown.blank?
      self.body_html = Maruku.new(self.body_markdown).to_html
    end
  end

  def adjust_front_page
    if is_front_page
      Page.update_all('is_front_page = false', ["id != ?", id])
    end
  end

  # Based on to_param of Hobo::Model
  def slugify(s)
    s.to_s.downcase.gsub(/[^a-z0-9]+/, '-').remove(/-+$/).remove(/^-+/) \
      .split('-')[0..5].join('-')
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
