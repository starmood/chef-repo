#
# Cookbook:: PDF-generic
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

### 1. Disable services

services = node["PDF-generic"]["disable_services"]

services.each do |service|
 
  service service do
    action [ :disable, :stop ]
  end
end


### 2. Add alias

maliases = node["PDF-generic"]["mail_alias"]

maliases.each do |malias|
	ruby_block "insert_line" do
	block do
		file = Chef::Util::FileEdit.new("/etc/aliases")
		file.insert_line_if_no_match(/#{malias}/, "#{malias}")
		file.insert_line_if_no_match(/#{malias}/, "abc")
		file.write_file
	end
	end
end