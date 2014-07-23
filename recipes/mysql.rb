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
