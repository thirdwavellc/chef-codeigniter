#
# Cookbook Name:: codeigniter
# Recipe:: site
#
# Copyright (C) 2014
#
#
#

web_app node['codeigniter']['site_name'] do
  server_name node['codeigniter']['hostname']
  server_aliases node['codeigniter']['aliases']
  docroot "/var/www/#{node['codeigniter']['docroot']}"
  allow_override true
end
