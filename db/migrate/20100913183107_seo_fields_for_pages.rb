class SeoFieldsForPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :page_title, :string
    add_column :pages, :keywords, :string
    add_column :pages, :description, :text
  end

  def self.down
    remove_column :pages, :page_title
    remove_column :pages, :keywords
    remove_column :pages, :description
  end
end
