class LifeCycleForPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :state, :string, :default => "drafted"
    add_column :pages, :key_timestamp, :datetime

    add_index :pages, [:state]
  end

  def self.down
    remove_column :pages, :state
    remove_column :pages, :key_timestamp

    remove_index :pages, :name => :index_pages_on_state rescue ActiveRecord::StatementInvalid
  end
end
