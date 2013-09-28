require "bundler/capistrano"
load "config/recipes/base"

set :remote_branch, 'origin/master'

set :application, "codecrowd-web"
set :app_root_folder, "/home/deployer/apps/#{application}/current"

set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:codecrowd/#{application}.git"
set :branch, "master"

set :unicorn_workers_count, 2

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    template "nginx.conf.erb", "/tmp/nginx.conf"
    sudo "mv /tmp/nginx.conf /etc/nginx/sites-enabled/#{application}"
    template "unicorn_init.sh.erb", "/tmp/unicorn_init.sh"
    sudo "mv /tmp/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    template "unicorn.rb.erb", "#{shared_path}/config/unicorn.rb"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/application.yml"), "#{shared_path}/config/application.yml"

    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == %x(git rev-parse #{remote_branch}) #`git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

end
