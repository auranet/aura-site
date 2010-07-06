class Initial < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text     :body
      t.boolean  :is_public
      t.string   :user_ip
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :entry_id
    end
    add_index :comments, [:user_id]
    add_index :comments, [:entry_id]

    create_table :tag_assignments do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :entry_id
      t.integer  :tag_id
    end
    add_index :tag_assignments, [:entry_id]
    add_index :tag_assignments, [:tag_id]

    create_table :tags do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :pages do |t|
      t.string   :name
      t.text     :body_markdown
      t.text     :body_html
      t.boolean  :is_front_page
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :menus do |t|
      t.string   :name
      t.string   :url
      t.boolean  :is_public, :default => true
      t.integer  :order_number
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :menu_id
    end
    add_index :menus, [:menu_id]

    create_table :entries do |t|
      t.string   :name
      t.text     :body_markdown
      t.text     :body_html
      t.string   :tagstring
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.string   :state, :default => "drafted"
      t.datetime :key_timestamp
    end
    add_index :entries, [:user_id]
    add_index :entries, [:state]

    create_table :media_files do |t|
      t.string   :content_type
      t.string   :filename
      t.integer  :size
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :name
      t.string   :email_address
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state, :default => "active"
      t.datetime :key_timestamp
    end
    add_index :users, [:state]
  end

  def self.down
    drop_table :comments
    drop_table :tag_assignments
    drop_table :tags
    drop_table :pages
    drop_table :menus
    drop_table :entries
    drop_table :media_files
    drop_table :users
  end
end
