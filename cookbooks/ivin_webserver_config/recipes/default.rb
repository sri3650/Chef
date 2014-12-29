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

execute "chown nginx_path log folder" do
  command "chown root:app -R /opt/nginx/logs/"
  command "chmod 777 /opt/nginx/logs/"
  command "chmod 666 /opt/nginx/logs/*"
  command "chmod 777 /mnt/log/nginx"
  command "chmod 666 /mnt/log/nginx/*"
end

execute "port redirection" do
  command "iptables -t mangle -A PREROUTING -p tcp --dport 80 -j MARK --set-mark 1"
  command "iptables -t mangle -A PREROUTING -p tcp --dport 443 -j MARK --set-mark 1"
  command "iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080"
  command "iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8181"
  command "iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -m mark --mark 1 -j ACCEPT"
  command "iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8181 -m mark --mark 1 -j ACCEPT"
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

template "#{node.default[:passenger][:path]}/conf/sites.d/ivin.conf" do
  source "rails_nginx_passenger.conf.erb"
  user "root"
  group "app"
  mode "664"
  notifies :restart, 'service[passenger]'
end