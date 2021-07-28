#
# Cookbook:: PDF-InsecureConnections
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node["PDF-InsecureConnections"]["if_allow"]
when 'yes', 'Yes', '1'
	# allow

else
                Chef::Log.info( "PDF-InsecureConnections: You choose dis-allow rsh/telnet, skip this recipe." )
                return	
end

case node['platform']
when 'redhat', 'centos'
        case node['platform_version'].to_i
	when 5,6,7

                %w{xinetd rsh telnet rsh-server telnet-server}.each do |package|
                  package package do
                        action :install
                  end
                end
		
		template "/root/.rhosts" do
			source 'rhosts.erb'
			mode '0400'
			owner 'root'
			group 'root'
			notifies :run, 'execute[pam_login]', :immediately
			notifies :run, 'execute[pam_remote]', :immediately
			notifies :run, 'execute[pam_rlogin]', :immediately
			notifies :run, 'execute[pam_rsh]', :immediately
		end
		case node['platform_version'].to_i
		when 5,6
	                %w{telnet rlogin rexec rsh}.each do |service|
	                  service service do
	                    action [ :enable ]
	                  end
	                end

		when 7
                        %w{telnet.socket rlogin.socket rexec.socket rsh.socket}.each do |service|
                          service service do
                            action [ :enable ]
                          end
                        end
		end

                %w{xinetd}.each do |service|
                  service service do
                    action [ :enable, :restart ]
                  end
                end


	else
		Chef::Log.info( "PDF-InsecureConnections: Only support Redhat/CentOS version 5,6,7 at this time." )
		return

	end

else
		Chef::Log.info( "PDF-InsecureConnections: Only Redhat-based systems are supported at this time." )
		return
end


execute 'pam_login' do
        command "sed -e '/securetty.so/s/^/\#/' -i.orig /etc/pam.d/login"
        action :nothing
end

execute 'pam_remote' do
        command "sed -e '/securetty.so/s/^/\#/' -i.orig /etc/pam.d/remote"
        action :nothing
end

execute 'pam_rlogin' do
        command "sed -e '/securetty.so/s/^/\#/' -i.orig /etc/pam.d/rlogin"
        action :nothing
end

execute 'pam_rsh' do
        command "sed -e '/securetty.so/s/^/\#/' -i.orig /etc/pam.d/rsh"
        action :nothing
end
