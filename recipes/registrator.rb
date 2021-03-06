container_path = '/var/lib/container/registrator'

tag = node['docker-simple']['registrator']['tag']
command = node['docker-simple']['registrator']['command']

compose = {
  'registrator' => {
    'image' => "joatmon08/registrator:#{tag}",
    'command' => command,
    'volumes' => [
      '/var/run/docker.sock:/tmp/docker.sock'
    ],
    'restart' => 'unless-stopped'
  }
}

directory container_path do
  owner 'root'
  group 'docker'
  mode '0644'
  recursive true
  action :create
end

chef_gem 'psych'
require 'psych'

file "#{container_path}/docker-compose.yml" do
  owner 'root'
  group 'docker'
  mode '0644'
  content Psych.dump(compose)
  action :create
end

bash 'Create and start container for registrator' do
  cwd container_path
  user 'root'
  code 'docker-compose up -d --no-color --no-recreate'
end
