#
# Cookbook Name:: database_backup
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/cron.d/mysql_backup" do
  source "mysql_backup"
  owner "root"
  group "root"
  mode "755"
end