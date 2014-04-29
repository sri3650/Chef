#
# Cookbook Name:: ivin_cloudwatch
# Recipe:: default
#
# Copyright 2013, Chronus Corporation
#
# All rights reserved - Do Not Redistribute
#

node.default[:packages_for_cloudwatch].each do |name|
  package name do
    action :install
  end
end

cloudwatch_app_directory = node.default[:ivin_application][:cloudwatch_app_path]

directory "#{cloudwatch_app_directory}" do
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "#{cloudwatch_app_directory}/CloudWatchClient.pm" do
  source "CloudWatchClient.pm"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "#{cloudwatch_app_directory}/mon-get-instance-stats.pl" do
  source "mon-get-instance-stats.pl"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "#{cloudwatch_app_directory}/mon-put-instance-data.pl" do
  source "mon-put-instance-data.pl"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "#{cloudwatch_app_directory}/awscreds.conf" do
  source "awscreds.conf"
  owner "root"
  group "root"
  mode "644"
end

cloudwatch_log_directory = node.default[:ivin_application][:cloudwatch_log_path]

directory "#{cloudwatch_log_directory}" do
  owner "root"
  group "root"
  mode "755"
end

template "/etc/cron.d/cloudwatch" do
  source "cloudwatch.erb"
  owner "root"
  group "root"
  mode "755"
end

template "/etc/logrotate.d/cloudwatch" do
  source "cloudwatch_logrotate.erb" 
  owner "root"
  group "root"
  mode "644"
end

template "/etc/cron.daily/post_cloudwatch_logrotate" do
  source "post_cloudwatch_logrotate.erb"
  owner "root"
  group "root"
  mode "755"
end