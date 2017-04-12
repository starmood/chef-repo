#
# Cookbook:: PDF-OMSA
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform']
when 'redhat', 'centos'
        case node['platform_version'].to_i
        when 6,7
		template "/etc/yum.repos.d/dell-system-update.repo" do
		        source "yum-repo-dell.erb"
		        mode "0644"
		end

                %w{srvadmin-all}.each do |package|

                  package package do
                        action :install
                  end
                end

	else 
                Chef::Log.info( "PDF-Nagios: Only support Redhat/CentOS version 6,7 at this time." )
                return
	end

else
        Chef::Log.info( "PDF-Nagios: Only Redhat-based systems are supported at this time." )
        return

end
