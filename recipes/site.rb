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
  allow_override 'All'
end

if node['codeigniter']['static_assets']
  node['codeigniter']['static_assets'].each do |asset|
    remote_file "#{Chef::Config[:file_cache_path]}/#{asset['filename']}" do
      source asset['url']
      mode "0644"
    end

    execute "untar-static-asset-#{asset['filename']}" do
      command "tar -xzf #{Chef::Config[:file_cache_path]}/#{asset['filename']} -C /var/www/#{node['codeigniter']['docroot']}/static"
      creates "/var/www/#{node['codeigniter']['docroot']}/static/#{asset['directory']}"
      action :run
    end
  end
end
