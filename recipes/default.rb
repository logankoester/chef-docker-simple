package('docker') { action :install }

template '/usr/lib/systemd/system/docker.service' do
  source 'docker.service.erb'
  action :create
  mode '0644'
end

template '/usr/lib/systemd/system/docker.socket' do
  source 'docker.socket.erb'
  action :create
  mode '0644'
end

directory '/etc/docker' do
  action :create
  mode '0644'
end

template '/etc/docker/env' do
  source 'docker_env.erb'
  action :create
  variables options: node['docker-simple']['options']
  mode '0644'
end

service 'docker' do
  supports status: true, restart: true
  action [:enable, :start]
end
