set :deploy_to, "/home/www/apps/#{application}/prod"
set :rails_env, "production"
# Deploy to production site only from stable branch
#set :branch, "stable"