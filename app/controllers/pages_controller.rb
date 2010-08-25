class PagesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    hobo_index Page.viewable(current_user)
  end
end
