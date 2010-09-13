class PageHints < Hobo::ViewHints

  # model_name "My Model"
  # field_names :field1 => "First Field", :field2 => "Second Field"
  # children :primary_collection1, :aside_collection1, :aside_collection2
  field_help :body_markdown => '
    Supports markdown formatting<br/>
    *emphasized* = <em>emphasized</em><br />
    **strong** = <strong>strong</strong><br />
    [Developer\'s Blog](http://www.tylerlesmann.com/) = <a href="http://www.tylerlesmann.com/">Developer\'s Blog</a><br />
    Go <a href="http://daringfireball.net/projects/markdown/syntax">here</a> for more information.',
    :is_erb => 'Checking this will cause body_html to be parsed with ERB.',
    :page_title => 'By default, we use the page name.  If you want something different, specify it here.'
end
