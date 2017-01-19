container_path = '/var/lib/container/swarm'

discovery = node['docker-simple']['swarm']['discovery']
worker_addr = node['docker-simple']['swarm']['worker']['addr']
manager_strategy = node['docker-simple']['swarm']['manager']['strategy']
certs_path = node['docker-simple']['swarm']['tls']['certs_path']

compose = {
  'version' => '2',
  'services' => {
    'worker' => {
      'image' => 'swarm',
      'command' => "join --advertise=#{worker_addr}:2376 #{discovery}",
      'restart' => 'unless-stopped'
    },
    'manager' => {
      'image' => 'swarm',
      'command' => [
        'manage',
        '--host 0.0.0.0:3376',
        "--strategy=#{manager_strategy}",
        '--replication',
        '--tls',
        '--tlscacert=/certs/ca.pem',
        '--tlscert=/certs/cert.pem',
        '--tlskey=/certs/key.pem',
        discovery].join(' '),
      'volumes' => [
        "#{certs_path}:/certs:ro"
      ],
      'ports' => ["#{worker_addr}:3376:3376"],
      'environment' => {
        'SERVICE_3376_NAME' => 'swarm'
      },
      'restart' => 'unless-stopped'
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
