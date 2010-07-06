module BloggerStructs
  class Blog < ActionWebService::Struct
    member :url,      :string
    member :blogid,   :string
    member :blogName, :string
  end
  class User < ActionWebService::Struct
    member :userid, :string
    member :firstname, :string
    member :lastname, :string
    member :nickname, :string
    member :email, :string
    member :url, :string
  end
end


class BloggerApi < ActionWebService::API::Base
  inflect_names false

  api_method :deletePost,
    :expects => [ {:appkey => :string}, {:postid => :int}, {:username => :string}, {:password => :string},
                  {:publish => :bool} ],
    :returns => [:bool]

  api_method :getUserInfo,
    :expects => [ {:appkey => :string}, {:username => :string}, {:password => :string} ],
    :returns => [BloggerStructs::User]

  api_method :getUsersBlogs,
    :expects => [ {:appkey => :string}, {:username => :string}, {:password => :string} ],
    :returns => [[BloggerStructs::Blog]]

end


class BloggerService < WebService
  web_service_api BloggerApi
  before_invocation :authenticate

  def deletePost(appkey, postid, username, password, publish)
    Entry.destroy(postid)
    true
  end

  def getUserInfo(appkey, username, password)
    BloggerStructs::User.new(
      :userid => username,
      :firstname => "",
      :lastname => "",
      :nickname => username,
      :email => "",
      :url => "/"
    )
  end

  def getUsersBlogs(appkey, username, password)
    [BloggerStructs::Blog.new(
      :url      => '/',
      :blogid   => 1,
      :blogName => 'Emmett'
    )]
  end

end
