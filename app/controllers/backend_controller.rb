class BackendController < ApplicationController

  web_service_dispatching_mode :layered

  web_service(:metaWeblog)  { MetaWeblogService.new(self) }
  web_service(:blogger)     { BloggerService.new(self) }

  def api
    dispatch_web_service_request
  end

end
