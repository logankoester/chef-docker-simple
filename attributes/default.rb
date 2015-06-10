default['docker-simple'] = {}
default['docker-simple']['options'] = {}

default['docker-simple']['options']['ip'] = '0.0.0.0'
default['docker-simple']['options']['graph'] = '/var/lib/docker'

default['docker-simple']['registrator']['tag'] = 'latest'
default['docker-simple']['registrator']['command'] = '-h $HOSTNAME consul:'

# If true, will *not* enable or start the docker service
default['docker-simple']['skip_service'] = false

default['containers'] = []
