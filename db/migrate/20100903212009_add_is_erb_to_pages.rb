class AddIsErbToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :is_erb, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :is_erb
  end
end
