set :stages, %w(beta production)
set :default_stage, "production"
require 'capistrano/ext/multistage'

set :application, "endlesss"
set :server_url, "endlesss.net"
set :repository,  "."

set(:dbuser) { Capistrano::CLI.ui.ask("What is your database username: ") }
set(:dbpassword){ Capistrano::CLI.password_prompt("What is the database password for user #{dbuser}: ") }

set(:s3_access_key) { Capistrano::CLI.ui.ask("What is your s3 access key: ") }
set(:s3_secret_access_key){ Capistrano::CLI.password_prompt("What is your secret s3 access key: ") }

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :user, "deploy"
set :use_sudo, false

# Deploy from Github
set :scm, :git
set :deploy_via, :remote_cache
set :repository,  "git@github.com:dedene/endlesss.git"
set :copy_remote_dir, "/home/#{user}"
set :branch, "master"
ssh_options[:forward_agent] = true
default_run_options[:pty] = true
set :scm_verbose, true
set :git_shallow_clone, 1

# Server definitions
role :app, server_url
role :web, server_url
role :db, server_url, :primary => true

namespace :deploy do
  desc "Restarting Passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

require 'erb'
before "deploy:setup", :db
before "deploy:setup", :s3
after "deploy:update_code", "db:symlink" 
#after "deploy:update_code", "s3:symlink" 

namespace :db do
  desc "Create database yaml in shared path"
  
  task :default do
    db_config = ERB.new <<-EOF
    base: &base
      adapter: mysql
      socket: /tmp/mysql.sock
      username: #{dbuser}
      password: #{dbpassword}

    alpha:
      database: #{application}_alpha
      <<: *base

    beta:
      database: #{application}_beta
      <<: *base

    production:
      database: #{application}_prod
      <<: *base
    EOF

    run "mkdir -p #{shared_path}/config" 
    put db_config.result, "#{shared_path}/config/database.yml" 
  end


  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end
end

namespace :s3 do
  desc "Create s3 yaml in shared path"
  
  task :default do
    s3_config = ERB.new <<-EOF
    access_key_id: #{s3_access_key}
    secret_access_key: #{s3_secret_access_key}
    EOF

    run "mkdir -p #{shared_path}/config" 
    put s3_config.result, "#{shared_path}/config/s3.yml" 
  end


  desc "Make symlink for s3 yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/s3.yml #{release_path}/config/s3.yml" 
  end
end

namespace :cloudfront do
  desc "Upload assets to Cloudfront for assets hosting" 
  task :upload do
    run("cd #{deploy_to}/current; rake cloudfront:upload RAILS_ENV=#{rails_env}")
  end
end

namespace :rake do
  desc "Show all rake tasks on server"
  task :show_tasks do
    run("cd #{deploy_to}/current; rake -T")
  end
  
  desc "Run a task on a remote server."  
  # run like: cap staging rake:invoke task=a_certain_task  
  task :invoke do  
    run("cd #{deploy_to}/current; /usr/bin/rake #{ENV['task']} RAILS_ENV=#{rails_env}")  
  end  
end

namespace :bundler do
  task :install, :roles => :app, :except => { :no_release => true }  do
    run("gem install bundler --source=http://gemcutter.org")
  end
 
  task :symlink_vendor, :roles => :app, :except => { :no_release => true } do
    shared_gems = File.join(shared_path, 'vendor/gems/ruby/1.9.1')
    release_gems = "#{release_path}/vendor/gems/ruby/1.9.1"
    # if you don't commit your cache, add cache to this list
    %w(gems specifications).each do |sub_dir|
      shared_sub_dir = File.join(shared_gems, sub_dir)
      run("mkdir -p #{shared_sub_dir} && mkdir -p #{release_gems} && ln -s #{shared_sub_dir} #{release_gems}/#{sub_dir}")
    end
  end
 
  task :install, :roles => :app, :except => { :no_release => true }  do
    bundler.symlink_vendor
    # if you don't commit your cache, remove --cached from this line
    run("cd #{release_path} && bundle install --without test")
  end
end
 
after 'deploy:update', 'bundler:install'
#after "deploy:update", "cloudfront:upload" 
