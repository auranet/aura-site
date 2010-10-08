Given /there is an admin user/ do
  User.create!(:name => "The Admin", :email_address => "admin@example.com", :administrator => true)
end
