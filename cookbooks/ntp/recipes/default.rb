#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'ntp'

 template 'etc/ntp.conf' do
   source 'ntp.conf.erb'
   notifies :restart, 'services[ntp]'
end

service  'ntp' do
 action [:enable, :start]

end 

