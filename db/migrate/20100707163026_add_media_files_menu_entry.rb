class AddMediaFilesMenuEntry < ActiveRecord::Migration
  def self.up
    Menu.create!(
      :menu => Menu.find_by_name('Admin'),
      :name => 'Media Files',
      :url => '/media_files',
      :is_public => false,
      :order_number => 0)
  end

  def self.down
    Menu.find_by_name('Media Files').destroy
  end
end
