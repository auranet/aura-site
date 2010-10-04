class EntriesController < ApplicationController

  hobo_model_controller

  auto_actions :all
  index_action :rss
  index_action :news

  def assign_tags
    params["entry"]["tags"] = params["entry"]["tagstring"].split(',').collect{
      |tag|
      '@' + Tag.find_or_create_by_name(tag.strip).id.to_s
    }
  end

  def index
    hobo_index Entry.viewable(current_user)
  end

  def create
    # Remove user spoofing
    # Hobo should make this easier
    params["entry"].delete("user_id")
    assign_tags
    hobo_create
  end

  def news
    hobo_index Entry.viewable(current_user).news
  end

  def rss
    @entries = Entry.find(:all, :conditions => {:state => 'published'}, :limit => 10)
  end

  def update
    assign_tags
    hobo_update
  end
end
