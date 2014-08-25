#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'ntp'

cookbook_file 'etc/ntp.conf' do
   source 'ntp.conf'
   notifies :restart, 'services[ntp]'
end

service  'ntp' do
 action [:enable, :start]

end 

