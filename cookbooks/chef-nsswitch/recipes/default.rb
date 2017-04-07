#
# Cookbook Name:: nsswitch
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

template '/etc/nsswitch.conf' do
  source 'nsswitch.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  variables({
    passwd:    node[:nsswitch][:passwd],
    group:     node[:nsswitch][:group],
    shadow:    node[:nsswitch][:shadow],    
    hosts:     node[:nsswitch][:hosts],   
    networks:  node[:nsswitch][:networks],
    protocols: node[:nsswitch][:protocols],
    services:  node[:nsswitch][:services],
    ethers:    node[:nsswitch][:ethers], 
    rpc:       node[:nsswitch][:rpc],   
    netgroup:  node[:nsswitch][:netgroup],
    automount: node[:nsswitch][:automount],
    aliases:   node[:nsswitch][:aliases]
  })
end
