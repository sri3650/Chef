#
# Cookbook Name:: chronus_gems
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.default[:gems].each do |gem_info|
  gem_package gem_info[0] do
	version gem_info[1] 
    action :install  
  end
end