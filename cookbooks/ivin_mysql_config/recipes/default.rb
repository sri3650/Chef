#
# Cookbook Name:: ivin_mysql_config
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "#{node['ivin_mysql']['conf_dir']}/my.cnf" do
  source "my.cnf.erb"
  owner "root" unless platform? 'windows'
  group node['ivin_mysql']['root_group'] unless platform? 'windows'
  mode "0644"
  case node['ivin_mysql']['reload_action']
  when 'restart'
    notifies :restart, "service[mysql]", :immediately
  when 'reload'
    notifies :reload, "service[mysql]", :immediately
  else
    Chef::Log.info "my.cnf updated but mysql.reload_action is #{node['ivin_mysql']['reload_action']}. No action taken."
  end
  variables :skip_federated => true
end

service "mysql" do
  # MySQL daemon runs in Standby only and not in Staging and Production
  # Skip starting the service if run from Staging and Production
  unless node['ivin_mysql']['reload_action'] == 'none'
    action :start
  else
    action :nothing
  end
end