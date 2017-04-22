#
# Cookbook:: PDF-motd
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template "/etc/motd" do
        source "PDF-motd.erb"
        mode "0644"
end

template "/etc/motd.warning" do
        source "PDF-motd.erb"
        mode "0644"
end
