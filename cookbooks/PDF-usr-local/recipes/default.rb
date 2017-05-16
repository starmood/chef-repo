#
# Cookbook:: PDF-usr-local
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['PDF-usr-local']['type']
when 'center','central','nfs'
        case node['platform']
        when 'redhat', 'centos'
                case node['platform_version'].to_i
                when 5,6
		           execute "mv_local" do
		            command "mv /usr/local /usr/local.orig_byChef"
		            not_if {File.symlink?('/usr/local') || !File.exist?('/usr/local')}
		            notifies :create, 'link[usr_local]', :immediately
		           end

		           link 'usr_local' do
		            link_type  :symbolic
		            target_file '/usr/local'
		            to '/tools/arch/linux-x86_64_26/local'
		            not_if {File.exist?('/usr/local')} 
		            action :nothing
		           end

                else
                        Chef::Log.info( "PDF-usr-local: Only support Redhat/CentOS version 5,6 at this time." )
                        return
                end



        else
                Chef::Log.info( "PDF-usr-local: Only Redhat-based systems are supported at this time." )
                return
        end

else
                Chef::Log.info( "PDF-usr-local: 'type' is not central, skip this recipe." )
                return

end
