#
# Cookbook Name:: imagemagick
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "ark"

ark 'imagemagick' do
  url "#{node.default[:imagemagick][:url]}"
  version "#{node.default[:imagemagick][:version]}"
  action :configure
  action :install_with_make
end
