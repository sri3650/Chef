#
# Cookbook Name:: patentdb_mysql_config
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "#{node['pdb_mysql']['conf_dir']}/my.cnf" do
  source "my.cnf.erb"
  owner "root" unless platform? 'windows'
  group node['pdb_mysql']['root_group'] unless platform? 'windows'
  mode "0644"
  case node['pdb_mysql']['reload_action']
  when 'restart'
    notifies :restart, "service[mysql]", :immediately
  when 'reload'
    notifies :reload, "service[mysql]", :immediately
  else
    Chef::Log.info "my.cnf updated but mysql.reload_action is #{node['pdb_mysql']['reload_action']}. No action taken."
  end
  variables :skip_federated => true
end

service "mysql" do
  action :start
end