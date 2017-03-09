template '/etc/consul/conf.d/swarm.json' do
  source 'swarm.json.erb'
  variables swarm: node['docker-simple']['swarm']
  action :create
  mode '0644'
end
