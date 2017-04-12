#
# Cookbook:: PDF-OMSA
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform']
when 'redhat', 'centos'

  case node['system']['manufacturer']
  when /Dell/i
    case node['system']['product_name']
    when /PowerEdge/i
        case node['platform_version'].to_i
        when 6,7
		template "/etc/yum.repos.d/dell-system-update.repo" do
		        source "yum-repo-dell.erb"
		        mode "0644"
		end

                %w{srvadmin-all}.each do |package|

                  package package do
                        action :install
			timeout 5400
                  end
                end

		execute 'start_omsa' do
			command '/opt/dell/srvadmin/sbin/srvadmin-services.sh start'
		end

	else 
                Chef::Log.info( "PDF-OMSA: Only support Redhat/CentOS version 6,7 at this time." )
                return
	end
    else
      Chef::Log.info( "PDF-OMSA: Only support Dell PowerEdge at this time." )                           
      return
    end

  else
    Chef::Log.info( "PDF-OMSA: Only support Dell hardware." ) 
    return
  end
else
        Chef::Log.info( "PDF-OMSA: Only Redhat-based systems are supported at this time." )
        return

end
