class PagesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    hobo_index Page.viewable(current_user)
  end

  def show
    if params[:id].nil? and params[:slug]
      params[:id] = model.find_by_slug(params[:slug], :select => :id)
    end
    hobo_show
  end
end
