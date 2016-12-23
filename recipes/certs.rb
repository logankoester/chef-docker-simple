ca_cert = ssl_certificate 'ca.dancesafe.org' do
  common_name 'ca_cert'
  source 'data-bag'
  bag 'ssl'
  item 'ca_cert'
  key_item_key 'key'
  cert_item_key 'cert'
end

file '/etc/docker/certs/ca/ca.pem' do
  owner 'root'
  group 'root'
  mode '0644'
  content ca_cert.cert_content
end

file '/etc/docker/certs/ca/key.pem' do
  owner 'root'
  group 'root'
  mode '0644'
  content ca_cert.key_content
end

cert = ssl_certificate 'docker' do
  cert_source 'with_ca'
  key_source 'self-signed'
  ca_cert_path '/etc/docker/certs/ca/ca.pem'
  ca_key_path '/etc/docker/certs/ca/key.pem'

  common_name node['docker-simple']['ssl']['domain']
  subject_alternate_names node['docker-simple']['ssl']['subject_alternate_names']
end

file '/etc/docker/certs/ca.pem' do
  owner 'root'
  group 'root'
  mode '0644'
  content ca_cert.cert_content
end

file '/etc/docker/certs/cert.pem' do
  owner 'root'
  group 'root'
  mode '0644'
  content cert.cert_content
end

file '/etc/docker/certs/key.pem' do
  owner 'root'
  group 'root'
  mode '0644'
  content cert.key_content
end
