remote_file '/usr/local/bin/wrapdocker' do
  source 'https://raw.githubusercontent.com/jpetazzo/dind/master/wrapdocker'
  action :create_if_missing
end

execute 'chmod +x /usr/local/bin/wrapdocker && wrapdocker'
