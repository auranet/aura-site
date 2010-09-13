namespace :aura do
  desc "Import external RSS and create blog entries"
  task :import_from_rss, :needs => :environment do
    RssEntryImport.run_imports
  end
end
