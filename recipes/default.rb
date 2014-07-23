#
# Cookbook Name:: codeigniter
# Recipe:: default
#
# Copyright (C) 2014
#
#
#

include_recipe 'apt::default'
include_recipe 'curl::default'
include_recipe 'git::default'
include_recipe 'php::default'
include_recipe 'apache2::default'
include_recipe 'apache2::mod_rewrite'
include_recipe 'codeigniter::mysql'
