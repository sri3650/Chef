#
# Cookbook Name:: ivin_appserver_dirs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/usr/local/chronus/bin/localeapp_start" do
  source "localeapp_start"
  owner "root"
  group "root"
  mode "775"
end

cookbook_file "/usr/local/chronus/bin/localeapp_stop" do
  source "localeapp_stop"
  owner "root"
  group "root"
  mode "775"
end