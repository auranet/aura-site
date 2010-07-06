require 'action_controller/test_process.rb'

module MetaWeblogStructs
  class Article < ActionWebService::Struct
    member :description,        :string
    member :title,              :string
    member :postid,             :string
    member :url,                :string
    member :link,               :string
    member :permaLink,          :string
    member :categories,         [:string]
    member :mt_text_more,       :string
    member :mt_excerpt,         :string
    member :mt_keywords,        :string
    member :mt_allow_comments,  :int
    member :mt_allow_pings,     :int
    member :mt_convert_breaks,  :string
    member :mt_tb_ping_urls,    [:string]
    member :dateCreated,        :time
  end

  class MediaObject < ActionWebService::Struct
    member :bits, :string
    member :name, :string
    member :type, :string
  end

  class Url < ActionWebService::Struct
    member :url, :string
  end
end


class MetaWeblogApi < ActionWebService::API::Base
  inflect_names false

  api_method :getCategories,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string} ],
    :returns => [[:string]]

  api_method :getPost,
    :expects => [ {:postid => :string}, {:username => :string}, {:password => :string} ],
    :returns => [MetaWeblogStructs::Article]

  api_method :getRecentPosts,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string}, {:numberOfPosts => :int} ],
    :returns => [[MetaWeblogStructs::Article]]

  api_method :deletePost,
    :expects => [ {:appkey => :string}, {:postid => :string}, {:username => :string}, {:password => :string}, {:publish => :int} ],
    :returns => [:bool]

  api_method :editPost,
    :expects => [ {:postid => :string}, {:username => :string}, {:password => :string}, {:struct => MetaWeblogStructs::Article}, {:publish => :int} ],
    :returns => [:bool]

  api_method :newPost,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string}, {:struct => MetaWeblogStructs::Article}, {:publish => :int} ],
    :returns => [:string]

  api_method :newMediaObject,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string}, {:data => MetaWeblogStructs::MediaObject} ],
    :returns => [MetaWeblogStructs::Url]

end


class MetaWeblogService < WebService
  web_service_api MetaWeblogApi
  before_invocation :authenticate

  def article_dto_from(entry)
    url = '/' + entry.to_url_path
    MetaWeblogStructs::Article.new(
      :description => entry.body_html,
      :title => entry.name,
      :postid => entry.id.to_s,
      :url => url,
      :link => url,
      :permaLink => url,
      :categories => entry.tags.collect{ |t| t.name },
      :dateCreated => entry.created_at.utc
    )
  end

  def deletePost(appkey, postid, username, password, publish)
    Entry.destroy(postid)
    true
  end

  def editPost(postid, username, password, struct, publish)
    entry = Entry.find(postid)
    save_post(entry, struct, publish)
    true
  end

  def getCategories(blogid, username, password)
    Tag.find(:all).collect { |c| c.name }
  end

  def getPost(postid, username, password)
    entry = Entry.find(postid)
    article_dto_from(entry)
  end

  def getRecentPosts(blogid, username, password, numberOfPosts)
    Entry.find(:all, :order => "created_at DESC", :limit => numberOfPosts).collect{ |c| article_dto_from(c) }
  end

  def newMediaObject(blogid, username, password, data)
    tf = File.new(File.join(Dir.tmpdir, File.basename(data['name'])), 'w')
    tf.write(data['bits'])
    tf.flush
    mf = MediaFile.new(:uploaded_data =>
      ActionController::TestUploadedFile.new(tf.path, data['type']))
    mf.save!
    tf.close()
    File.delete(tf.path)
    MetaWeblogStructs::Url.new("url" => mf.public_filename)
  end

  def newPost(blogid, username, password, struct, publish)
    entry = Entry.new
    save_post(entry, struct, publish)
    entry.id.to_s
  end

  def save_post(entry, struct, publish)
    entry.body_markdown = '' # Markdown will be compiled otherwise
    entry.body_html = struct['description'] || ''
    entry.name = struct['title'] || ''
    entry.user = @user
    if struct['categories']
      entry.tagstring = struct['categories'].join(', ')
    else
      entry.tagstring = ''
    end

    if publish
      entry.state = 'published'
    end
    entry.save!
  end
end
