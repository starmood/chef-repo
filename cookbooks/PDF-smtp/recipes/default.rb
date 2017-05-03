#
# Cookbook:: PDF-smtp
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

current_time = Time.new.strftime("%Y%m%d%H%M%S")

case node['platform']
when 'redhat', 'centos'
	case node['platform_version'].to_i
	when 5,6
                %w{sendmail sendmail-cf}.each do |package|
                  package package do
                        action :install
                  end
                end

		remote_file "/etc/mail/sendmail.mc.beforeChef.#{current_time}" do
			source 'file:///etc/mail/sendmail.mc'
			action :create
		end

		template "/etc/mail/sendmail.mc" do
			source 'sendmail.mc.erb'
			mode '0644'
			owner 'root'
			group 'root'
			notifies :run, 'execute[m4]', :immediately
			notifies :run, 'execute[newaliases]', :immediately
		end

                %w{postfix}.each do |service|
                  service service do
                    action [ :stop, :disable ]
                  end
                end

		%w{sendmail}.each do |service|
		  service service do
		    action [ :enable, :restart ]
		  end
		end
	when 7
                %w{postfix}.each do |package|
                  package package do
                        action :install
                  end
                end

                %w{sendmail}.each do |service|
                  service service do
                    action [ :stop, :disable ]
                  end
                end

                %w{postfix}.each do |service|
                  service service do
                    action [ :enable, :restart ]
                  end
                end

	else
		Chef::Log.info( "PDF-smtp: Only support Redhat/CentOS version 5,6,7 at this time." )
		return
	end

else
	Chef::Log.info( "PDF-smtp: Only Redhat-based systems are supported at this time." )
	return
end

execute 'm4' do
	command 'm4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf'
	action :nothing
end

execute 'newaliases' do
	command 'newaliases'
	action :nothing
end
