require 'spec_helper'

describe 'nsswitch::default' do

  describe file('/etc/nsswitch.conf') do

    # Attributes set up in .kitchen.yml
    {
      passwd: 'files passwdtest',
      group: 'files grouptest',
      shadow: 'files shadowtest',
      hosts: 'files dns hoststest',
      networks: 'files networkstest',
      protocols: 'db files protocolstest',
      services: 'db files servicestest',
      ethers: 'db files etherstest',
      rpc: 'db files rpctest',
      netgroup: 'nis netgrouptest',
      automount: 'files automounttest',
      aliases: 'files aliasestest'
    }.each do |attribute, value|

      its(:content) { should match /^#{attribute}:\s*#{value}$/}

    end

  end

end