#
# Cookbook Name:: database_backup
# Recipe:: mysql full backup
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/cron.d/mysql_full_backup" do
  source "mysql_full_backup"
  owner "root"
  group "root"
  mode "775"
end