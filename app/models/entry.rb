class Entry < ActiveRecord::Base
  hobo_model # Don't put anything above this

  before_save :process_markdown, :save_tags

  fields do
    name          :string
    body_markdown :text
    body_html     :raw_html
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

  named_scope :news, lambda {
    bad_ids = Entry.not_news.all(:select => 'entries.id').collect{|e| e.id}
    {
      :conditions => ['entries.id NOT IN (?)', bad_ids],
      :order => 'entries.updated_at DESC',
    }
  }

  named_scope :not_news, {
    :joins => :tags,
    :conditions => ['tags.name = ?', 'not-news'],
    :order => 'entries.updated_at DESC',
  }

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

  # Parse an RSS and create an entry for each based on title
  def self.from_rss(url, author, options={})
    require 'rss'

    defaults = {
      :publish => true,
    }
    options = defaults.merge(options)
    entries = []
    rss = nil
    open(url) do |stream|
      rss = RSS::Parser.parse(stream.read, false)
    end

    rss.items.reverse.each do |item|
      if not Entry.find_by_name(item.title)
        entry = Entry.create!(
          :name => item.title,
          :body_html => (item.content_encoded or item.description),
          :tagstring => item.categories.collect{|c| c.content}.join(', '),
          :user => author
        )
        if options[:publish]
          entry.lifecycle.publish! author
        end
        entries << entry
      end
    end
    entries
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
