#
# Cookbook:: PDF-autofs-pvg
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#%w{autofs nfs-utils nfs-utils-lib rpcbind}.each do |package|

%w{autofs nfs-utils rpcbind}.each do |package|
 
  package package do
    action :install
  end
end

template "/etc/auto.master" do
        source "auto.master.erb"
        mode "0644"
	notifies :enable, "service[autofs]"
	notifies :restart, "service[autofs]", :immediately
end

service "autofs" do
        action :nothing
end

