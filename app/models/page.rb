class Page < ActiveRecord::Base
  hobo_model # Don't put anything above this

  before_save :process_markdown
  after_save :adjust_front_page

  fields do
    name          :string
    body_markdown :text
    body_html     :raw_html
    is_front_page :boolean
    timestamps
  end

  set_search_columns :name, :body_html

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
    true
  end

end
