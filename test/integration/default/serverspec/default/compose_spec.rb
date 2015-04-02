require 'spec_helper'

describe command('docker-compose --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /docker-compose/ }
end

describe file('/var/lib/container/nginx') do
  it { should be_directory }
end

describe file('/var/lib/container/nginx/docker-compose.yml') do
  it { should be_file }
end

describe process('nginx') do
  it { should be_running }
end

describe command('(cd /var/lib/container/nginx; docker inspect $(docker-compose ps -q))') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain('/"Running": true/') }
end
