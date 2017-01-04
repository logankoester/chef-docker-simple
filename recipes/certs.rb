# Install vault-pki-client and configure it to request and
# manage the lifecycle of Docker certificates.

include_recipe 'pacman'

%w{ vault-pki-client }.each do |pkg|
  pacman_aur(pkg) do
    action [:build, :install]
    notifies :create, 'template[vault-pki-client-config]', :immediately
  end
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
