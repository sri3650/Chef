#
# Cookbook Name:: common_apts
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/apt/sources.list" do
  source "sources.list"
  owner "root"
  group "root"
  mode "644"
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

# Run apt-get update to create the stamp file
execute "apt-get-update" do
  command "sudo add-apt-repository ppa:alestic && apt-get update"
end

node.default[:common_packages].each do |name|
  package name do
    action :install
  end
end