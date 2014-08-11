#
# Cookbook Name:: ivin_appserver_dirs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
appservers_s3cfg = Chef::EncryptedDataBagItem.load("appservers_s3cfg", "cfg", secret)

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

%w{app admin ubuntu root}.each do |u|
  home_dir = "/home/#{u}"
  home_dir = "/root" if u == 'root'

  # cookbook_file "#{home_dir}/.s3cfg" do
  template "#{home_dir}/.s3cfg" do
    variables(:access_key => appservers_s3cfg["access_key"],
               :secret_key => appservers_s3cfg["secret_key"])

    owner u
    group u
    mode "0600"
    source "s3cfg.erb"
  end
end

template "/etc/cron.daily/post_appserver_logrotate" do
  source "post_appserver_logrotate.erb"
  owner "root"
  group "root"
  mode "755"
end