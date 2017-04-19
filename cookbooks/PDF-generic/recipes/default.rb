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
		file.write_file
	end
	end
end

### 3. Change password

case node["PDF-generic"]["role"]
when 'db'
        password_hash = '$1$Qc5lKa1J$fkWfzMIk7j4TxuP2uox/4.'

when "cv"
        password_hash = '$1$qI1VdCfW$C4/u8zeZURJmXMeoPalGd/'

when "IT"
        password_hash = '$1$uxeVk/4Z$/uEhIunfFWeFuj2IipCNw.'
else
        password_hash = '$1$qI1VdCfW$C4/u8zeZURJmXMeoPalGd/'
end

user "Set root password" do
        username 'root'
        password password_hash
        action :modify

end
