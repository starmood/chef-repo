#
# Cookbook:: PDF-nagios
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform']
when 'redhat', 'centos'
	case node['platform_version'].to_i
	when 5,6,7
		link '/tools/pvglocal/nagios/linux_2.6_x64_rh5' do
			to '/opt/nagios'

		end

		template "/etc/xinet.d/nrpe" do
		        source "nrpe.erb"
		        mode "0644"
			owner "root"
			group "root"
	        	variables({
      	 	        	only_from: node['PDF-nagios']['nrpe']['only_from']
			}
	       		)
		end
	else
		Chef::Log.info( "PDF-Nagios: Only support Redhat/CentOS version 5,6,7 at this time." )
		return
	end

else
	Chef::Log.info( "PDF-Nagios: Only Redhat-based systems are supported at this time." )
	return
end
