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
  docroot "/var/www/cumminsallison.com"
  allow_override true
end
