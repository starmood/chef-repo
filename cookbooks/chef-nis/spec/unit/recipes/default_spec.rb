require 'spec_helper'

describe 'nis::default' do 

  let(:chef_run) do 
    
    ChefSpec::Runner.new(platform: platform, version: version) do |node|
      node.set[:nis][:domain] = 'test.domain.pri'
    end.converge(described_recipe)

  end

  ######################################################################
  # Tests specific to Ubuntu                                           #
  ######################################################################

  context 'On Ubuntu 14.04' do

    let(:platform) { 'ubuntu' } 
    let(:version) { '14.04' }    
    let(:preseed_template) { chef_run.template('/var/cache/local/preseeding/nis.seed') }

    it 'creates the preseeding directory' do
      expect(chef_run).to create_directory('/var/cache/local/preseeding').with(
        owner: 'root',
        group: 'root',
        mode:  '0700',
        recursive: true
      )
    end

    it 'writes the preseed file' do

      expect(chef_run).to create_template('/var/cache/local/preseeding/nis.seed').with(
        owner: 'root',
        group: 'root',
        mode:  '0600'
      )

      expect(chef_run).to render_file('/var/cache/local/preseeding/nis.seed').with_content(%r{nis\s*nis/domain\s*string\s*test.domain.pri})
    end

    it 'sends a notification run debconf-set-selections' do
      expect(preseed_template).to notify('execute[preseed nis]').immediately
    end

    it 'does not run debconf-set-selections by default' do
      execute = chef_run.execute('preseed nis')
      expect(execute).to do_nothing
    end

    it 'installs the correct package' do
      expect(chef_run).to install_package('nis')
    end

    it 'enables the ypbind service' do
      expect(chef_run).to enable_service('ypbind')
    end

  end

  ######################################################################
  # Tests specific to CentOS                                           #
  ######################################################################

  context 'On CentOS 6.5' do

    let(:platform) { 'centos' } 
    let(:version) { '6.5' }  

    it 'installs the correct package' do
      expect(chef_run).to install_package('ypbind')
      expect(chef_run).to install_package('rpcbind')
    end

    it 'runs authconfig' do
      expect(chef_run).to run_execute('Configure NIS with authconfig')
    end

  end

  ######################################################################
  # Tests common to all platforms                                      #
  ######################################################################
  context 'On all platforms' do

    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:nis][:domain] = 'test.domain.pri'
      end.converge(described_recipe)
    end

    context 'when restricted to specific users/netgroups' do
    
      let(:chef_run) do 
        
        ChefSpec::Runner.new do |node|
          node.set[:nis][:domain] = 'test.domain.pri'
          node.set[:nis][:restricted_to] = ['jeff','@Usysgrp']
        end.converge(described_recipe)

      end

      it 'configures restricted access in /etc/passwd' do
        expect(chef_run).to run_ruby_block('Configure restricted access in /etc/passwd')
        expect(chef_run).to_not run_ruby_block('Configure unrestricted access in /etc/passwd')
      end

    end

    context 'when unrestricted access is allowed' do

      it 'configures unrestricted access in /etc/passwd' do
        expect(chef_run).to run_ruby_block('Configure unrestricted access in /etc/passwd')
        expect(chef_run).to_not run_ruby_block('Configure restricted access in /etc/passwd')
      end

    end

    it 'writes /etc/yp.conf' do
      expect(chef_run).to create_template('/etc/yp.conf').with(
        owner: 'root',
        group: 'root',
        mode:  '0644'
      )
    end

    it 'includes the nsswitch::default recipe' do
      expect(chef_run).to include_recipe('nsswitch::default')
    end

  end

end
