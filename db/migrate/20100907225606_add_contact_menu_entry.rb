class AddContactMenuEntry < ActiveRecord::Migration
  def self.up
    Menu.create!(
      :name => 'Contact',
      :url => '/contact',
      :is_public => true,
      :order_number => 30)
  end

  def self.down
    Menu.find_by_name('Contact').destroy
  end
end
