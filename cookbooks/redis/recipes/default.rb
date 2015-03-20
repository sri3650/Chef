#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
packages_dir = "/root/packages/"
remote_file "#{packages_dir}redis-#{node[:redis][:version]}.tar.gz" do
  source "#{node[:redis][:url]}"
  not_if { ::File.exists?("#{packages_dir}redis-#{node[:redis][:version]}.tar.gz") }
end

execute "Extract redis source" do
  cwd packages_dir
  command "tar -zxvf #{packages_dir}redis-#{node[:redis][:version]}.tar.gz"
  not_if { ::File.exists?("#{packages_dir}redis-#{node[:redis][:version]}") }
end

execute "Build and Install Redis Server" do
  cwd "#{packages_dir}redis-#{node[:redis][:version]}"
  command "make"
end

execute "Move server and client files of redis" do
  cwd "#{packages_dir}redis-#{node[:redis][:version]}"
  command "cp src/redis-server src/redis-cli /usr/bin"
  not_if { ::File.exists?("/usr/bin/redis-server") && ::File.exists?("/usr/bin/redis-cli")}
end

template "/etc/redis.conf" do
  source "redis.conf.erb"
  owner "root"
  group "root"
  mode "644"
  variables node[:redis]
end

cookbook_file "/etc/init.d/redis" do
  source "redis_init"
  owner "root"
  group "root"
  mode "755"
end

template "/etc/cron.daily/post_redis_logrotate" do
  source "post_redis_logrotate.erb"
  owner "root"
  group "root"
  mode "755"
end

template "/etc/logrotate.d/redis" do
  source "redis.erb"
  owner "root"
  group "root"
  mode "644"
end
