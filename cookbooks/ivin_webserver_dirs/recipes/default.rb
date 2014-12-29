#
# Cookbook Name:: ivin_webserver_dirs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "Create the nginx log directory" do
  command "mkdir -p /mnt/log/nginx && chown app:app /mnt/log/nginx"  
  not_if { ::File.exists?("/mnt/log/nginx") }
end

cookbook_file "/etc/init.d/nginx" do
  source "nginx-init"
  owner "root"
  group "app"
  mode "775"
end

template "/etc/logrotate.d/nginx" do
  source "nginx.erb" 
  owner "root"
  group "app"
  mode "664"
end

template "/etc/cron.daily/post_webserver_logrotate" do
  source "post_webserver_logrotate.erb"
  owner "root"
  group "app"
  mode "775"
end

# template "/usr/local/chronus/bin/passenger_monitor.sh" do
#   source 'passenger_monitor.sh.erb'
#   owner "root"
#   group "root"
#   mode 0755  
# end

#ask arun abt the last one here