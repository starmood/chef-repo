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

default[:nsswitch][:passwd]    = 'files'
default[:nsswitch][:group]     = 'files'
default[:nsswitch][:shadow]    = 'files'
default[:nsswitch][:hosts]     = 'files dns'
default[:nsswitch][:networks]  = 'files'
default[:nsswitch][:protocols] = 'db files' 
default[:nsswitch][:services]  = 'db files'
default[:nsswitch][:ethers]    = 'db files'
default[:nsswitch][:rpc]       = 'db files'
default[:nsswitch][:netgroup]  = 'nis'
default[:nsswitch][:automount] = 'files'
default[:nsswitch][:aliases]   = 'files'
