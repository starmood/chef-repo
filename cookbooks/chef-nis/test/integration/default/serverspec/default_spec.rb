require 'spec_helper'

describe 'nis::default' do

  describe 'nis service' do
    it 'is running' do
      expect(service('ypbind')).to be_running
    end
  end

  describe command('ypdomainname') do
    it { should return_stdout('csd.uwo.ca') }
  end

  describe file('/etc/passwd') do
    its(:content) { should_not match(/^\+/) }
    its(:content) { should_not match(%r{^\+:\*:0:0:::/bin/false}) }  
  end

  # FIXME: Comment these out if you're not running these in Western's CS department

  describe user('jshantz4') do
    it { should have_login_shell '/usr/shells/tcsh' }
  end

  describe user('jeff') do
    it { should have_login_shell '/bin/bash' }
  end

  describe user('ciaa2000') do
    it { should have_login_shell '/admin/bin/ac_off' }
  end

end
