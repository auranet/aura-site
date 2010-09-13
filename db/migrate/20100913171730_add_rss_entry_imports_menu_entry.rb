class AddRssEntryImportsMenuEntry < ActiveRecord::Migration
  def self.up
    Menu.create!(
      :menu => Menu.find_by_name('Admin'),
      :name => 'RSS Entry Imports',
      :url => '/rss_entry_imports',
      :is_public => false,
      :order_number => 0)
  end

  def self.down
    Menu.find_by_name('RSS Entry Imports').destroy
  end
end
