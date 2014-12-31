#
# Cookbook Name:: ivin_webserver_config
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

nginx_path = node[:passenger][:path]
nginx_log_path = node[:passenger][:nginx_log_path]
tuned_ruby_path = node[:passenger][:tuned_ruby_path]

cookbook_file "/etc/iptables.dump" do
  owner "root"
  group "app"
  mode 0775
  source 'iptables.dump'
end

execute "iptables-restore" do
  command "iptables-restore < /etc/iptables.dump"
end

template "#{nginx_path}/conf/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "app"
  mode 0664
  variables(    
    :nginx_log_path => nginx_log_path,    
    :passenger_root => "##PASSENGER_ROOT##",
    :ruby_path => tuned_ruby_path,
    :passenger => node[:passenger],
    :pidfile => "#{nginx_path}/logs/nginx.pid"
  )
  notifies :run, 'bash[config_patch]'
end

bash "config_patch" do
  # The big problem is that we can't compute the gem install path
  # because we don't know what ruby version we're being installed
  # on if RVM is present.
  # only_if "grep '##PASSENGER_ROOT##' #{nginx_path}/conf/nginx.conf"
  user "root"
  group "app"
  code "#{nginx_path}/sbin/config_patch.sh #{nginx_path}/conf/nginx.conf"
  notifies :reload, 'service[passenger]'
end

service "passenger" do
  service_name "passenger"
  reload_command "sudo -u app #{nginx_path}/sbin/nginx -s reload"
  start_command "sudo -u app #{nginx_path}/sbin/nginx"
  stop_command "sudo -u app #{nginx_path}/sbin/nginx -s stop"
  status_command "curl http://localhost:8080/nginx_status"
  supports [ :start, :stop, :reload, :status, :enable ]
  action [ :enable, :start ]
  pattern "nginx: master"
end

template "#{node.default[:passenger][:path]}/conf/sites.d/ivin.conf" do
  source "rails_nginx_passenger.conf.erb"
  user "root"
  group "app"
  mode "664"
  notifies :restart, 'service[passenger]'
end