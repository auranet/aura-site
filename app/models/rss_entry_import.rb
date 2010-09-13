class RssEntryImport < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    url :string
    publish_on_import :boolean
    timestamps
  end

  belongs_to :user

  def name
    "Import from #{url}"
  end

  def run
    entries = Entry.from_rss(url, user, :publish => publish_on_import)
    if not entries.empty?
      Rails.logger.info "Imported #{entries.length} entries from #{url}."
    end
  end

  def self.run_imports
    find(:all).each{ |import| import.run }
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
    acting_user.administrator?
  end

end
