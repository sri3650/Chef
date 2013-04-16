#
# Cookbook Name:: ivin_appserver_dirs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/usr/local/chronus/bin/localeapp_start" do
  source "localeapp_start"
  owner "root"
  group "root"
  mode "775"
end

cookbook_file "/usr/local/chronus/bin/localeapp_stop" do
  source "localeapp_stop"
  owner "root"
  group "root"
  mode "775"
end

%w{app admin ubuntu root}.each do |u|
  home_dir = "/home/#{u}"
  home_dir = "/root" if u == 'root'

  cookbook_file "#{home_dir}/.s3cfg" do
    owner u
    group u
    mode "0600"
    source "s3cfg"
  end
end