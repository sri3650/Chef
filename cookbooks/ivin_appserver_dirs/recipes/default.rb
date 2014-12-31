#
# Cookbook Name:: ivin_appserver_dirs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
appservers_s3cfg = Chef::EncryptedDataBagItem.load("aws", "creds", secret)

execute "chmod 666 all .logs" do
  command "chmod 666 /mnt/app/shared/log/*.log"
end

execute "chmod 666 all .logs" do
  command "chmod 666 /mnt/log/*.log"
end

cookbook_file "/usr/local/chronus/bin/localeapp_start" do
  source "localeapp_start"
  owner "app"
  group "app"
  mode "775"
end

cookbook_file "/usr/local/chronus/bin/localeapp_stop" do
  source "localeapp_stop"
  owner "app"
  group "app"
  mode "775"
end

%w{app ubuntu ivin_admin}.each do |u|
  home_dir = "/home/#{u}"

  template "#{home_dir}/.s3cfg" do
    variables(:access_key => appservers_s3cfg["access_key"], :secret_key => appservers_s3cfg["secret_key"])
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