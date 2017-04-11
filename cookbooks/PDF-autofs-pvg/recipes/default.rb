#
# Cookbook:: PDF-autofs-pvg
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

%w{autofs nfs-utils nfs-utils-lib rpcbind}.each do |package|
 
  package package do
    action :install
  end
end

template "/etc/auto.master" do
        source "auto.master.erb"
        mode "0644"
end

%w{autofs rpcbind nfs}.each do |service|
 
  service service do
    action [ :enable, :restart ]
  end
end
