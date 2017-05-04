#
# Cookbook:: PDF-OMSA
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


case node['platform']
when 'redhat', 'centos'
  unless node['dmi']['system']        # sometimes, dmi attribute hash is empty
      Chef::Log.info( "PDF-OMSA: Cannot detect hardware model." ) 
  else
      case node['dmi']['system']['manufacturer']
      when /Dell/i
        case node['dmi']['system']['product_name']
        when /PowerEdge/i
            case node['platform_version'].to_i
            when 6,7
    		template "/etc/yum.repos.d/dell-system-update.repo" do
    		        source "yum-repo-dell.erb"
    		        mode "0644"
    		end

                package 'srvadmin-all' do
                        action :install
			timeout 5400
			notifies :run, 'execute[start_omsa]', :immediately
                end

    		execute 'start_omsa' do
    			command '/opt/dell/srvadmin/sbin/srvadmin-services.sh start'
			action :nothing
    		end

    		%w{snmpd}.each do |service|
     
    		  service service do
    		    action [ :restart ]
    		  end
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
  end
else
        Chef::Log.info( "PDF-OMSA: Only Redhat-based systems are supported at this time." )
        return

end
