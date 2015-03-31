require 'spec_helper'

describe 'docker-simple::default' do
  before do
    Fauxhai.mock(path: 'spec/fixtures/arch.json') do |node|
    end
    # stub_data_bag('some_data_bag').and_return(['some_item'])
    # stub_data_bag_item_from_file 'some_data_bag', 'some_item'
  end

  context 'Install Docker' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        # node.set['some_attribute'] = {}
      end.converge(described_recipe)
    end

    it 'should install the docker package' do
      expect(chef_run).to install_package 'docker'
    end

    it 'should enable the docker service' do
      expect(chef_run).to enable_service 'docker'
    end

    it 'should start the docker service' do
      expect(chef_run).to start_service 'docker'
    end

    it 'should create the systemd docker.service template' do
      expect(chef_run).to create_template '/usr/lib/systemd/system/docker.service'
    end

    it 'should create the systemd docker.socket template' do
      expect(chef_run).to create_template '/usr/lib/systemd/system/docker.socket'
    end

    it 'should create the Docker env template' do
      expect(chef_run).to create_template '/etc/docker/env'
    end

  end
end
