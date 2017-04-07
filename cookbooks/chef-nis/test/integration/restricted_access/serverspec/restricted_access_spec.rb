require 'spec_helper'

describe 'nis::default on restricted_access' do

  describe 'nis service' do
    it 'is running' do
      expect(service('ypbind')).to be_running
    end
  end

  describe command('ypdomainname') do
    it { should return_stdout('csd.uwo.ca') }
  end

  describe file('/etc/passwd') do
    its(:content) { should match(%r{\+jshantz4::::::$}) }
    its(:content) { should match(%r{^\+@Usysgrp::::::$}) }
    its(:content) { should match(%r{^\+:\*:0:0:::/bin/false}) }
  end

  # FIXME: Comment these out if you're not running these in Western's CS department

  # A user listed in node[:nis][:restricted_to]
  describe user('jshantz4') do
    it { should have_login_shell '/usr/shells/tcsh' }
  end

  # A user that is part of a netgroup listed in node[:nis][:restricted_to]
  describe user('jeff') do
    it { should have_login_shell '/bin/bash' }
  end

  # A user that is not part of node[:nis][:restricted_to]
  describe user('ciaa2000') do
    it { should have_login_shell '/bin/false' }
  end

end
