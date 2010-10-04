role :web, "www.aura-software.com"
role :app, "www.aura-software.com"
role :db,  "www.aura-software.com", :primary => true
set :git_enable_submodules, 1

namespace :aura do
  task :link_config do
    run "ln -sf #{shared_path}/config/aura.yml #{release_path}/config/aura.yml"
  end
  task :link_media_files do
    run "ln -sf #{shared_path}/media_files #{release_path}/public/media_files"
  end
end

after "deploy:finalize_update", "aura:link_config"
after "deploy:finalize_update", "aura:link_media_files"
