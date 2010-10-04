class PagesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    hobo_index Page.viewable(current_user)
  end

  def show
    if params[:id].nil? and params[:slug]
      page = model.find_by_slug(params[:slug])
    else
      page = model.find_by_id(params[:id].to_i)
    end

    if page
      fresh_when :etag => page, :last_modified => page.updated_at
    end
    hobo_show page
  end
end
