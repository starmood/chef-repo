#
# Cookbook:: test_motd
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

cookbook_file "/etc/motd" do
	source "motd"
	mode "0644"
end
