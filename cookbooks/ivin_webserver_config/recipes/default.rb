#
# Cookbook Name:: ivin_webserver_config
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "#{node.default[:passenger][:path]}/conf/sites.d/ivin.conf" do
  source "rails_nginx_passenger.conf.erb"
  mode "644"
  notifies :restart, 'service[passenger]'
end