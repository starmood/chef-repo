#
# Cookbook:: PDF-nagios
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Notes: Current NRPE was compiled on CentOS5 with openssl 0.9.x, it does not support openssl 1.x
#	 So, on CentOS6,7, must install openssl098e package.

case node['platform']
when 'redhat', 'centos'
	case node['platform_version'].to_i
	when 5
		%w{xinetd openssl openssl-0.9.8e}.each do |package|

		  package package do
		  	action :install
		  end
		end

	when 6

                %w{xinetd openssl openssl098e.x86_64}.each do |package|

                  package package do
                        action :install
                  end
                end

        when 7

                %w{openssl openssl098e.x86_64}.each do |package|

                  package package do
                        action :install
                  end
                end

	else
		Chef::Log.info( "PDF-Nagios: Only support Redhat/CentOS version 5,6,7 at this time." )
		return
	end

        link '/opt/nagios' do
                to node['PDF-nagios']['nrpe']['path']

        end

	case node['platform_version'].to_i
	when 5,6
	        template "/etc/xinetd.d/nrpe" do
	                source "nrpe.erb"
	                mode "0644"
	                owner "root"
	                group "root"
	                variables({
	                        only_from: node['PDF-nagios']['nrpe']['only_from']
	                }
	                )
			notifies :enable, "service[xinetd]"
			notifies :restart, "service[xinetd]", :immediately
	        end

	when 7
		template "/usr/lib/systemd/system/nrpe.service" do
			source "nrpe.service.erb"
			mode "0644"
			owner "root"
			group "root"
			notifies :enable, "service[nrpe]"
			notifies :restart, "service[nrpe]", :immediately
		end
	end

else
	Chef::Log.info( "PDF-Nagios: Only Redhat-based systems are supported at this time." )
	return
end

# RH 5,6
service "xinetd" do
        action :nothing
end

# RH 7
service "nrpe" do
        action :nothing
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/services")
    file.insert_line_if_no_match(/nrpe/, "nrpe            5666/tcp                        # NRPE")
    file.write_file
  end
  #notifies :restart, "service[xinetd]", :immediately
  notifies :enable, "service[xinetd]"
  notifies :restart, "service[xinetd]"
end

