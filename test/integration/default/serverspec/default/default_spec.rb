require 'spec_helper'

describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end

describe package('docker') do
  it { should be_installed }
end

describe package('docker-machine') do
  it { should be_installed }
end

describe file('/etc/docker') do
  it { should be_directory }
end

describe file('/usr/lib/systemd/system/docker.service') do
  it { should be_file }
end

describe file('/usr/lib/systemd/system/docker.socket') do
  it { should be_file }
end

describe file('/etc/docker/env') do
  it { should be_file }
end

describe file('/etc/docker/env') do
  its(:content) { should match(/0\.0\.0\.0/) }
  its(:content) { should match(/\/var\/lib\/docker/) }
end
