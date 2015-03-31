require 'spec_helper'

describe command('docker-compose --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /docker-compose/ }
end
