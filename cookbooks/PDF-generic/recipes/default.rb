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
