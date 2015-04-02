include_recipe 'pacman'

%w{
  python2-texttable
  python2-websocket-client-pebble
  python2-docker-py
  python2-dockerpty
  docker-compose
}.each do |pkg|
  pacman_aur(pkg){ action [:build, :install] }
end

data_bag('containers').each do |app_id|
  next unless node['containers'].include? app_id
  app = data_bag_item 'containers', app_id

  # Generate docker-compose.yml from data bag item
  directory "/var/lib/container/#{app_id}" do
    owner 'root'
    group 'docker'
    mode '0644'
    recursive true
    action :create
  end

  chef_gem 'psych'
  require 'psych'

  file "/var/lib/container/#{app_id}/docker-compose.yml" do
    owner 'root'
    group 'docker'
    mode '0644'
    content Psych.dump(app['compose'])
    action :create
  end

  bash "Build, (re)create, start and attach to containers for #{app_id}" do
    cwd "/var/lib/container/#{app_id}"
    user "root"
    code "docker-compose up -d --no-color --no-recreate"
  end
end
