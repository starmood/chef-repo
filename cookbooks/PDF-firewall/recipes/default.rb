#
# Cookbook:: PDF-firewall
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['PDF-firewall']['status']
when 'disable', 'disabled'
	include_recipe "firewall::disable_firewall"

end
