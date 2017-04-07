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

include_attribute "nsswitch"

default[:nis][:domain] = 'csd.uwo.ca'

# If left empty, ypbind will resort to a broadcast
default[:nis][:servers] = []

# Use the :restricted_to attribute to restrict access to the server by
# username and/or netgroup.  Users should be specified by username.  Netgroups
# should be specified by '@GROUPNAME' syntax.  For example, to restrict access
# to the server to the user 'jeff' and all members of the netgroup 'Usysgrp',
# use the following in the node's configuration:
#
# "nis" => {
#   "restricted_to" => ["jeff", "@Usysgrp"]
# }
#
# For background information, see the 'Compatibility mode (compat)' section in
# 'man nsswitch.conf' on an Ubuntu system.
#
default[:nis][:restricted_to] = []

# Ensure that /etc/nsswitch.conf is configured appropriately for NIS
default[:nsswitch][:passwd]    = node[:nis][:restricted_to].empty? ? 'files nis' : 'compat'
default[:nsswitch][:group]     = 'files nis'
default[:nsswitch][:shadow]    = node[:nis][:restricted_to].empty? ? 'files nis' : 'compat'
default[:nsswitch][:hosts]     = 'files dns'
default[:nsswitch][:netgroup]  = 'nis'
default[:nsswitch][:automount] = 'files nis'
default[:nsswitch][:aliases]   = 'files nis'