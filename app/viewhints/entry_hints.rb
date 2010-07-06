class EntryHints < Hobo::ViewHints

  # model_name "My Model"
  # field_names :field1 => "First Field", :field2 => "Second Field"
  # field_help :field1 => "Enter what you want in this field"
  # children :primary_collection1, :aside_collection1, :aside_collection2
  field_names :name => "Title", :body_markdown => "Body", :tagstring => "Tags"
  field_help  :body_markdown => '
    Supports markdown formatting<br/>
    *emphasized* = <em>emphasized</em><br />
    **strong** = <strong>strong</strong><br />
    [Developer\'s Blog](http://www.tylerlesmann.com/) = <a href="http://www.tylerlesmann.com/">Developer\'s Blog</a><br />
    Go <a href="http://daringfireball.net/projects/markdown/syntax">here</a> for more information.',
    :tagstring => "Separate tags with commas ','.  Spaces are allowed."
  children :comments
end
