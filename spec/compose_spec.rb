require 'spec_helper'

describe 'docker-simple::compose' do
  before do
    Fauxhai.mock(path: 'spec/fixtures/arch.json') do |node|
    end
     stub_data_bag('containers').and_return(['nginx'])
     stub_data_bag_item_from_file 'containers', 'nginx'
  end

  context 'Install Docker Composer' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        # node.set['some_attribute'] = {}
      end.converge(described_recipe)
    end

    it 'should include pacman for AUR install' do
      expect(chef_run).to include_recipe 'pacman'
    end
  end

  context 'Install docker-composer.yml files from data bags' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['containers'] = ['nginx']
      end.converge(described_recipe)
    end

    it 'should create directory /var/lib/container/nginx' do
      expect(chef_run).to create_directory '/var/lib/container/nginx'
    end

    it 'should create docker-compose.yml files ' do
      expect(chef_run).to create_file '/var/lib/container/nginx/docker-compose.yml'
    end
  end
end
