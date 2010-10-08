Given /there is a (|front )page "([^"]*)" with markdown "([^"]*)"/ do |front, title, content|
  page = Page.create!(
    :name => title,
    :body_markdown => content,
    :is_front_page => (front == 'front ')
  )
  page.state = 'published'
  page.save!
end
