#
# Cookbook:: PDF-password
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

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
