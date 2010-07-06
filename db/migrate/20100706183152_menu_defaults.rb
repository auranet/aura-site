class MenuDefaults < ActiveRecord::Migration
  def self.up
    Menu.create!(
      :name => 'Admin',
      :url => '',
      :is_public => false,
      :order_number => 0)
    Menu.create!(
      :menu => Menu.find_by_name('Admin'),
      :name => 'Menus',
      :url => '/menus',
      :is_public => false,
      :order_number => 0)
    Menu.create!(
      :menu => Menu.find_by_name('Admin'),
      :name => 'Pages',
      :url => '/pages',
      :is_public => false,
      :order_number => 0)
    Menu.create!(
      :name => 'Home',
      :url => '/',
      :is_public => true,
      :order_number => 10)
    Menu.create!(
      :name => 'Blog',
      :url => '/entries',
      :is_public => true,
      :order_number => 20)
  end

  def self.down
    Menu.find_by_name('Menus').destroy
    Menu.find_by_name('Pages').destroy
    Menu.find_by_name('Admin').destroy
    Menu.find_by_name('Home').destroy
    Menu.find_by_name('Blog').destroy
  end
end
