#
# Cookbook Name:: common_apts
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

e = execute "apt-get update" do
  action :nothing
end

e.run_action(:run)  # need to run this before installing further packages. Refer http://docs.opscode.com/resource_common_compile.html

node.default[:packages].each do |name|
  package name do
    action :install
  end
end