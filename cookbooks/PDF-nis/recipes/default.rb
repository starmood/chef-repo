#
# Cookbook:: PDF-nis
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


include_recipe 'nis'

service "ypbind" do
	action :nothing
end

file '/tmp/for_restart_ypbind' do
	content 'fake file'
	notifies :restart, "service[ypbind]", :immediately

end

