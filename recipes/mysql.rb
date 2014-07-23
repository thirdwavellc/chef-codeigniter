#
# Cookbook Name:: codeigniter
# Recipe:: mysql
#
# Copyright (C) 2014
#
#
#

apt_repository 'mysql-5.6' do
  uri          'http://ppa.launchpad.net/ondrej/mysql-5.6/ubuntu'
  distribution node['lsb']['codename']
  components   ['main']
  keyserver    'keyserver.ubuntu.com'
  key          'E5267A6C'
end

package 'mysql-server'
package 'php5-mysql'

execute 'change-mysql-root-password' do
  command "mysqladmin -u root password #{node['mysql']['server_root_password']} && touch /var/lib/mysql/password_updated"
  creates '/var/lib/mysql/password_updated'
  action :run
end

execute 'create-database' do
  command "mysqladmin -u root -p#{node['mysql']['server_root_password']} create #{node['codeigniter']['db']['name']}"
end

if node['codeigniter']['db']['backup']
  remote_file "#{Chef::Config[:file_cache_path]}/backup.sql.tar.gz" do
    source node['codeigniter']['db']['backup']
    mode "0644"
  end

  execute "untar-mysql-backup" do
    cwd Chef::Config[:file_cache_path]
    command "tar -xzf #{Chef::Config[:file_cache_path]}/backup.sql.tar.gz"
    creates "#{Chef::Config[:file_cache_path]}/backup.sql"
    action :run
  end

  execute "import-db" do
    command "mysql --password=#{node['mysql']['server_root_password']} #{node['codeigniter']['db']['name']} < #{Chef::Config[:file_cache_path]}/backup.sql"
    action :run
  end
end
