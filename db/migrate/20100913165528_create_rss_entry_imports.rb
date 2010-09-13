class CreateRssEntryImports < ActiveRecord::Migration
  def self.up
    create_table :rss_entry_imports do |t|
      t.string   :url
      t.boolean  :publish_on_import
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    add_index :rss_entry_imports, [:user_id]
  end

  def self.down
    drop_table :rss_entry_imports
  end
end
