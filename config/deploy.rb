# config valid for current version and patch releases of Capistrano
lock "~> 3.13.0"

set :application, "pro_books"
set :repo_url, "https://github.com/hikaru9507/ProBooks.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ec2-user/ProBooks"
set :rbenv_ruby, '2.5.7'
set :linked_files, %w{config/master.key .env}
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

#--------画像追加のために追加したコード
# desc 'upload master.key'
# task :upload do
# 	on roles(:app) do |host|
# 	  if test "[ ! -d #{shared_path}/config ]"
# 		execute "mkdir -p #{shared_path}/config"
# 	  end
# 	  upload!('config/master.key', "#{shared_path}/config/master.key")
# 	end
#   end
#   before :starting, 'deploy:upload'
#   after :finishing, 'deploy:cleanup'
# end