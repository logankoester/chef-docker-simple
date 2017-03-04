# Install vault-pki-client and enable as system service to issue and continually refresh
# credentials from Hashicorp Vault's PKI Secrets Backend before they expire.

include_recipe 'pacman'
pacman_aur('vault-pki-client'){ action [:build, :install] }

template '/etc/vault-pki-client/config' do
  source 'vault-pki-client/config.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables :vault => node['docker-simple']['vault'],
    :cert => node['docker-simple']['cert']
  notifies :restart, 'service[vault-pki-client]', :immediate
end

service 'vault-pki-client' do
  action [ :enable, :start ]
end
