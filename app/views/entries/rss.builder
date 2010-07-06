xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("Taming Hobo with Tyler Lesmann")
    xml.link("http://hobo.tylerlesmann.com/")
    xml.description("Newest entries")
    xml.language('en-us')
      for entry in @entries
        xml.item do
          xml.title(entry.name)
          xml.description(entry.body_html)
          xml.author(entry.user)
          xml.link(url_for(:only_path => false, :controller => 'entries', :action => 'show', :id => entry.id))
          xml.guid(url_for(:only_path => false, :controller => 'entries', :action => 'show', :id => entry.id))
        end
      end
  }
}
