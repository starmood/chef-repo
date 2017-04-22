require 'spec_helper'

describe 'nsswitch::default' do 

  ######################################################################
  # Tests common to all platforms                                      #
  ######################################################################
  context 'On all platforms' do

    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'writes /etc/nsswitch.conf' do
      expect(chef_run).to create_template('/etc/nsswitch.conf').with({
        owner: 'root',
        group: 'root',
        mode:  '0644'
      })
    end

    %w[
      passwd group shadow hosts networks protocols services ethers rpc 
      netgroup automount aliases 
    ].each do |attribute|

      context "when the #{attribute} attribute is set" do

        let(:chef_run) do
          ChefSpec::Runner.new do |node|
            node.set[:nsswitch][attribute.to_sym] = 'testing'
          end.converge(described_recipe)
        end

        it 'is written to /etc/nsswitch.conf' do
          expect(chef_run).to render_file('/etc/nsswitch.conf').with_content(/^#{attribute}:\s*testing$/)
        end

      end

    end

  end

end
