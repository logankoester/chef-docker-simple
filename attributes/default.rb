default['docker-simple'] = {}
default['docker-simple']['options'] = {}

default['docker-simple']['options']['ip'] = '0.0.0.0'
default['docker-simple']['options']['graph'] = '/var/lib/docker'
default['docker-simple']['options']['host'] = 'fd://'
default['docker-simple']['options']['dns'] = '8.8.8.8'
default['docker-simple']['options']['cluster_store'] = 'consul://127.0.0.1:8500/swarm'

default['docker-simple']['registrator']['tag'] = 'latest'
default['docker-simple']['registrator']['command'] = '-h $HOSTNAME consul:'

# If true, will *not* enable or start the docker service
default['docker-simple']['skip_service'] = false

default['containers'] = []

default['docker-simple']['swarm']['discovery'] = 'consul://127.0.0.1:8500'
default['docker-simple']['swarm']['worker']['addr'] = '0.0.0.0'
default['docker-simple']['swarm']['manager']['strategy'] = 'spread'
default['docker-simple']['swarm']['tls']['certs_path'] = '/etc/docker/certs'

default['docker-simple']['vault']['server']['address'] = node['etc_environment']['VAULT_ADDR']
default['docker-simple']['vault']['server']['ca-cert'] = node['etc_environment']['VAULT_CACERT']
default['docker-simple']['vault']['pki']['path'] = 'certs'
default['docker-simple']['vault']['pki']['role'] = 'service.consul'
default['docker-simple']['vault']['token'] = node['etc_environment']['VAULT_TOKEN']
