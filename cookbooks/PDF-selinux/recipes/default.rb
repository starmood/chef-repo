#
# Cookbook:: PDF-selinux
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe "selinux"

Chef::Log.info('**************************************************************************')
Chef::Log.info('If you disable SELINUX, you must reboot server first to make it effective!')
Chef::Log.info('**************************************************************************')

