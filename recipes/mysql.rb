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

mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database_user node['codeigniter']['db']['user'] do
  connection mysql_connection_info
  password node['codeigniter']['db']['user_password']
  action :create
end

mysql_database node['codeigniter']['db']['name'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['codeigniter']['db']['user'] do
  connection mysql_connection_info
  database_name node['codeigniter']['db']['name']
  privileges [:all]
  action :grant
end
