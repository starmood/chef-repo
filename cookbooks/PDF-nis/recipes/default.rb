#
# Cookbook:: PDF-nis
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


include_recipe 'nis'

service "ypbind" do
	action :nothing
end

service "ypbind-enable" do
	action :enable
	notifies :restart, "service[ypbind]", :immediately
end

