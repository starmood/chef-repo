#
# Cookbook:: PDF-nis
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


include_recipe 'nis"

%w{ypbind}.each do |service|
  service service do
    action [ :enable, :restart ]
  end
end
