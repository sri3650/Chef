#
# Cookbook Name:: ivin_apts
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.default[:packages].each do |name|
  package name do
    action :install
  end
end