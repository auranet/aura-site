class CommentsController < ApplicationController

  hobo_model_controller

  auto_actions :destroy
  auto_actions_for :entry, [:new, :create]

  def create
    hobo_create
  end

  def create_for_entry
    # Remove user spoofing
    # Hobo should make this easier
    params["comment"].delete("user_id")
    params["comment"]["user_ip"] = request.remote_ip
    hobo_create
  end
end
