#
# Cookbook Name:: nis
# Recipe:: default
#
# Copyright 2014, Western University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

packages = value_for_platform(
  'centos' => { 'default' => %w[ypbind rpcbind] },
  'ubuntu' => { 'default' => %w[nis] },
  'default' => []
)

# If we're on Ubuntu, preseed the NIS domain before installing the 'nis' package
if platform?('ubuntu')

  directory '/var/cache/local/preseeding' do
    owner     'root'
    group     'root'
    mode      '0700'
    recursive true
  end

  execute 'preseed nis' do
    command 'debconf-set-selections /var/cache/local/preseeding/nis.seed'
    action :nothing
  end

  template '/var/cache/local/preseeding/nis.seed' do
    source  'nis.seed.erb'
    owner   'root'
    group   'root'
    mode    '0600'
    variables({
      domain: node[:nis][:domain]
    })
    notifies :run, 'execute[preseed nis]', :immediately
  end

end

# Install the appropriate packages
packages.each do |pkg|
  package pkg
end

# Define and enable the ypbind server 
service 'ypbind' do

  case node[:platform]
  when "ubuntu"
    provider Chef::Provider::Service::Upstart
  end

  supports :restart => true, :status => true
  action :enable
end

# If we're on CentOS, configure NIS using the 'authconfig' command
if platform?('centos')

  execute 'Configure NIS with authconfig' do
    command "authconfig --enablenis --nisdomain=#{node[:nis][:domain]} --update"
  end

end

# Write /etc/yp.conf and restart the ypbind service, if necessary
template "/etc/yp.conf" do
  source "yp.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  variables(
    domain: node[:nis][:domain],
    servers: node[:nis][:servers]
  )
  
  notifies :restart, "service[ypbind]"

end

# If we're restricting access to the host to one or more users
if ! Array(node[:nis][:restricted_to]).empty?

  # Write the appropriate lines to /etc/passwd
  ruby_block "Configure restricted access in /etc/passwd" do
    block do 
      passwd = Chef::Util::FileEdit.new('/etc/passwd')
      passwd.search_file_delete_line(/^\+/)

      node[:nis][:restricted_to].each do |entity|
        passwd.insert_line_if_no_match(/^\+#{entity}::::::$/, "+#{entity}::::::")
      end

      passwd.insert_line_if_no_match(%r{^\+:\*:0:0:::/bin/false$}, "+:*:0:0:::/bin/false")
      passwd.write_file
    end
  end
    
else

  # Otherwise, ensure /etc/passwd is free of any restrictions
  ruby_block "Configure unrestricted access in /etc/passwd" do
    block do
      passwd = Chef::Util::FileEdit.new('/etc/passwd')
      passwd.search_file_delete_line(/^\+/)
      passwd.write_file
    end

  end

end

# Write /etc/nsswitch.conf so that NIS is enabled
include_recipe "nsswitch::default"
