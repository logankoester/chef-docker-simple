container_path = '/var/lib/container/swarm'

discovery = node['docker-simple']['swarm']['discovery']
worker_addr = node['docker-simple']['swarm']['worker']['addr']
manager_host = node['docker-simple']['swarm']['manager']['host']
manager_strategy = node['docker-simple']['swarm']['manager']['strategy']
certs_path = node['docker-simple']['swarm']['tls']['certs_path']

compose = {
  'version' => '2',
  'services' => {
    'worker' => {
      'image' => 'swarm',
      'command' => "join --advertise=#{worker_addr}:2375 #{discovery}"
    },
    'manager' => {
      'image': 'swarm',
      'command' => "manage \
        --host #{manager_host}:3376 \
        --strategy '#{manager_strategy}' \
        --tlsverify \
        --tlscacert=/certs/ca.pem \
        --tlscert=/certs/cert.pem \
        --tlskey=/certs/key.pem \
        #{discovery}",
      'volumes' => [
        "#{certs_path}:/certs:ro"
      ],
      'ports' => ['3376:3376'],
      'environment' => {
        'SERVICE_NAME' => 'swarm'
      }
    }
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

bash 'Create and start containers for swarm worker and manager' do
  cwd container_path
  user 'root'
  code 'docker-compose up -d --no-color --no-recreate'
end
