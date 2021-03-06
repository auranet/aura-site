class FrontController < ApplicationController

  hobo_controller

  def index
    @page = Page.viewable(current_user).find_by_is_front_page(true)
    @news = Entry.viewable(current_user).news.all(:limit => 10)
    @title = "Home"
    if @page
      if !@page.page_title.blank?
        @title = @page.page_title
      else
        @title = @page.name
      end
    end

    mdate = nil
    if @page and !@news.empty?
      mdate = @page.updated_at > @news[0].updated_at ? @page.updated_at : @news[0].updated_at
    elsif @page
      mdate = @page.updated_at
    elsif !@news.empty?
      mdate = @news[0].updated_at
    end
  end

  def summary
    if !current_user.administrator?
      redirect_to user_login_path
    end
  end

  def search
    if params[:query]
      site_search(params[:query])
    end
  end

end
