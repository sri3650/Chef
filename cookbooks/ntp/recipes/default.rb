#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
# package 'ntp' do
package "#{node.default[:ntp][:package]}" do
 action :install
end

execute "restart_ntp" do
  command "/etc/init.d/ntp restart"
  action :nothing
end

cookbook_file '/etc/ntp.conf' do
   source 'ntp.conf'
    owner "root"
    group "root"
    mode "644"
    notifies :run, "execute[restart_ntp]", :immediately
 end

service  'ntp' do
 action [:enable, :start]
end
