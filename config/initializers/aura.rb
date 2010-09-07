config = YAML::load(File.open(File.join(RAILS_ROOT, 'config', 'aura.yml')))
errors = []

# Sanity checking!
unless config['recaptcha'].is_a? Hash and
  config['recaptcha']['public_key'].is_a? String and
  config['recaptcha']['private_key'].is_a? String
  errors << 'recaptcha config is invalid.'
end

unless config['contact_emails'].is_a? Array
  errors << 'contact_emails should be a list of email addresses.'
end

unless config['from_email'].is_a? String
  errors << 'from_email is not defined.'
end

unless config['rakismet'].is_a? Hash and
  config['rakismet']['key'].is_a? String and
  config['rakismet']['url'].is_a? String and
  config['rakismet']['host'].is_a? String
  errors << 'rakismet config is invalid.'
end

unless errors.empty?
  puts 'Errors were found in your aura.yml:'
  errors.each do |e|
    puts "  #{e}"
  end
  exit
end

ENV['RECAPTCHA_PUBLIC_KEY'] = config['recaptcha']['public_key']
ENV['RECAPTCHA_PRIVATE_KEY'] = config['recaptcha']['private_key']
Rakismet::KEY = config['rakismet']['key']
Rakismet::URL = config['rakismet']['url']
Rakismet::HOST = config['rakismet']['url']
Aura::CONFIG = config
