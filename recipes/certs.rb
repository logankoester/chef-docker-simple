# Install vault-pki-client and configure it to request and
# manage the lifecycle of Docker certificates.

include_recipe 'nodejs::npm'

nodejs_npm 'vault-pki-client'

template '/usr/lib/systemd/system/vault-pki-client.service' do
  source 'vault-pki-client/service.erb'
  action :create
  mode '0644'
end

template 'vault-pki-client-config' do
  path '/etc/vault-pki-client/config' 
  source 'vault-pki-client/config.erb'
  action :create
  variables options: node['docker-simple']['pki']
  mode '0644'
  notifies :restart, 'service[vault-pki-client]', :immediately
end

service 'vault-pki-client' do
  supports status: true, restart: true
  action [:enable, :start]
end
