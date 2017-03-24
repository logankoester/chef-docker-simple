default['docker-simple'] = {}
default['docker-simple']['options'] = {}

default['docker-simple']['options']['ip'] = '0.0.0.0'
default['docker-simple']['options']['graph'] = '/var/lib/docker'
default['docker-simple']['options']['host'] = 'fd://'
default['docker-simple']['options']['dns'] = '8.8.8.8'

default['docker-simple']['registrator']['tag'] = 'latest'
default['docker-simple']['registrator']['command'] = '-h $HOSTNAME consul:'

# If true, will *not* enable or start the docker service
default['docker-simple']['skip_service'] = false

default['containers'] = []

default['docker-simple']['vault']['server']['address'] = node['etc_environment']['VAULT_ADDR']
default['docker-simple']['vault']['server']['ca-cert'] = node['etc_environment']['VAULT_CACERT']
default['docker-simple']['vault']['pki']['path'] = 'certs'
default['docker-simple']['vault']['pki']['role'] = 'service.consul'
default['docker-simple']['vault']['token'] = node['etc_environment']['VAULT_TOKEN']

default['docker-simple']['cert']['certIPs'] = ['127.0.0.1']
default['docker-simple']['cert']['certTTL'] = '2160h'
