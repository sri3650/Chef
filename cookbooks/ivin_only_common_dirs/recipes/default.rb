#
# Cookbook Name:: ivin_only_common_dirs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/cron.d/ec2-snapshots" do
  source "ec2-snapshots.erb"
  owner "root"
  group "root"
  mode "644"
end