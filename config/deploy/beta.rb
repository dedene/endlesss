set :deploy_to, "/home/www/apps/#{application}/beta"
set :rails_env, "beta"
# Deploy to beta/production site only from stable branch
set :branch, "stable"