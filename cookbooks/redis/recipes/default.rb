#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/tmp/redis-#{node[:redis][:version]}.tar.gz" do
  source "#{node[:redis][:url]}"
  not_if { ::File.exists?("/tmp/redis-#{node[:redis][:version]}.tar.gz") }
end

execute "Extract redis source" do
  cwd "/tmp"
  command "tar -zxvf /tmp/redis-#{node[:redis][:version]}.tar.gz"
  not_if { ::File.exists?("/tmp/redis-#{node[:redis][:version]}") }
end

execute "Build and Install Redis Server" do
  cwd "/tmp/redis-#{node[:redis][:version]}"
  command "make"
end

execute "Move server and client files of redis" do
  cwd "/tmp/redis-#{node[:redis][:version]}"
  command "cp src/redis-server src/redis-cli /usr/bin"
  not_if { ::File.exists?("/usr/bin/redis-server") && ::File.exists?("/usr/bin/redis-cli")}
end

template "/etc/redis.conf" do
  source "redis.conf.erb"
  owner "root"
  group "app"
  mode "664"
  variables node[:redis]
end

cookbook_file "/etc/init.d/redis" do
  source "redis_init"
  owner "root"
  group "app"
  mode "775"
end

template "/etc/cron.daily/post_redis_logrotate" do
  source "post_redis_logrotate.erb"
  owner "root"
  group "app"
  mode "775"
end

template "/etc/logrotate.d/redis" do
  source "redis.erb"
  owner "root"
  group "app"
  mode "664"
end
