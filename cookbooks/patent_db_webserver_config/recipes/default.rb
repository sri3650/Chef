#
# Cookbook Name:: patent_db_webserver_config
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "#{node.default[:passenger][:path]}/conf/sites.d/patent_db.conf" do
  source "rails_nginx_passenger_patent_db.conf.erb"
  mode "644"
  notifies :restart, 'service[passenger]'
end