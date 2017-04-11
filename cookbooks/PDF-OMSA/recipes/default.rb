#
# Cookbook:: PDF-OMSA
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template "/etc/yum.repos.d/dell-system-update.repo" do
        source "yum-repo-dell.erb"
        mode "0644"
end
