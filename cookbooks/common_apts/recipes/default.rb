#
# Cookbook Name:: common_apts
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#resize filesystem
["/dev/sda1", "/dev/xvda1"].each do |file_system|
  execute "resize2fs #{file_system}" do
    command "sudo resize2fs #{file_system}"
    only_if "test -b #{file_system}"
  end
end

# Run apt-get update to create the stamp file
execute "apt-get-update" do
  command "sudo add-apt-repository ppa:alestic && apt-get update"
end

cookbook_file "/etc/apt/sources.list" do
  source "sources.list"
  owner "root"
  group "root"
  mode "644"
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

node.default[:common_packages].each do |name|
  package name do
    action :install
  end
end