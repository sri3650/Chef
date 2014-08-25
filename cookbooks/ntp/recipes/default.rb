#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
package 'ntp'

service  'ntp' do
 supports :status => true, :restart => true
 action [:enable, :start]
end

execute "restart_ntp" do
  command "/etc/init.d/ntp restart"
end

cookbook_file '/etc/ntp.conf' do
   source 'ntp.conf'
    owner "root"
    group "root"
    mode "644"
    notifies :restart, resources(:execute => "restart_ntp")
 end
