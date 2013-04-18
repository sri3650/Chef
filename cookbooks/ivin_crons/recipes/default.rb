#
# Cookbook Name:: ivin_crons
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

deploy_user = node.default[:ivin_application][:deploy_user]
cookbook_file "/var/spool/cron/crontabs/#{deploy_user}" do #if the file is edited from the ec2 machine, it will be overwritten in the next chef - run. crons should always be edited from chef
  source "#{deploy_user}"
  owner "#{deploy_user}"
  group "crontab"
  mode "600"
end

cookbook_file "/var/spool/cron/crontabs/root" do
  source "root"
  owner "root"
  group "crontab"
  mode "600"
end

cookbook_file "/etc/cron.hourly/app" do
  source "app_hourly_cron"
  owner "root"
  group "root"
  mode "755"
end