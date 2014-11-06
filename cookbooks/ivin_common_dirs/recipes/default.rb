#
# Cookbook Name:: ivin_common_dirs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
deploy_keys = Chef::EncryptedDataBagItem.load("deploy_keys", "id_rsa", secret)
aws_data = Chef::EncryptedDataBagItem.load("aws", "creds", secret)
bucket = node[:ivin_application][:credentials_bucket]

execute "touch the files in syslogd-listfiles" do
  for l in command("syslogd-listfiles -a").split("\n") do
    command "touch #{l}"
  end
end

# Here it is assumed that restart will succeed even if the syslogd is not previously not running
service "sysklogd" do
   supports :restart => true, :status => false
   action [ :enable, :restart ]
end

execute "Create the app directory" do
  command "mkdir -p /mnt/app && chown app:app /mnt/app"  
  not_if { ::File.exists?("/mnt/app") }
end

execute "Create the tmp directory" do  
  command "mkdir -p /mnt/tmp && chmod 777 /mnt/tmp"  
  not_if { ::File.exists?("/mnt/tmp") }
end 

execute "Create the log directory" do  
  command "mkdir -p /mnt/log && chown app:app /mnt/log"  
  not_if { ::File.exists?("/mnt/log") }
end

execute "Create the chronus bin directory" do  
  command "mkdir -p /usr/local/chronus/bin && chmod 777 /usr/local/chronus/bin"  
  not_if { ::File.exists?("/usr/local/chronus/bin") }
end 

execute "Create the chronus lib directory" do  
  command "mkdir -p /usr/local/chronus/lib && chown root:root /usr/local/chronus/lib"  
  not_if { ::File.exists?("/usr/local/chronus/lib") }
end

template "/etc/app.yml" do
  source "app.yml.erb"
  owner "root"
  group "root"
  mode "644"
end

template "/etc/init.d/system-restart-email" do
  source 'system-restart-email.erb'
  owner "root"
  group "root"
  mode 0755  
end

bash "Configure system restart email" do
  user "root"
  code <<-EOH
  cd /etc/init.d
  update-rc.d system-restart-email start 98 2 3 4 5 . stop 02 0 1 6 .
  EOH
  not_if "test -e /etc/rc0.d/K02system-restart-email"
end

#ask arun the abv four

template "/etc/logrotate.d/rails" do
  source "rails.erb"
  owner "root"
  group "root"
  mode "644"
end

template "/etc/cron.daily/post_common_logrotate" do
  source "post_common_logrotate.erb"
  owner "root"
  group "root"
  mode "755"
end

template "/usr/local/chronus/bin/mailgun_log_retention.rb" do
  source "mailgun_log_retention.rb"
  owner "root"
  group "root"
  mode "755"
end


cookbook_file "/etc/logrotate.d/rsyslog" do
  source "rsyslog"
  owner "root"
  group "root"
  mode "644"
end

cookbook_file "/usr/local/chronus/bin/ec2-create-snapshot" do
  source "ec2-create-snapshot"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "/usr/local/chronus/bin/ec2-delete-old-snapshots" do
  source "ec2-delete-old-snapshots"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "/etc/environment" do
  source "environment"
  owner "root"
  group "root"
  mode "644"
end

cookbook_file "/etc/ssh/sshd_config" do
  source "sshd_config"
  owner "root"
  group "root"
  mode "644"
end

cookbook_file "/usr/local/chronus/bin/archive_file.rb" do
  source "archive_file.rb"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "/usr/local/chronus/bin/backup_app_db.rb" do
  source "backup_app_db.rb"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "/usr/local/chronus/bin/pull_latest_credentials.rb" do
  source "pull_latest_credentials.rb"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "/usr/local/chronus/bin/rails_env" do
  source "rails_env"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "/usr/local/chronus/bin/restore_app_db.rb" do
  source "restore_app_db.rb"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file  "/usr/local/chronus/bin/update_hostname" do
  owner "root"
  group "root"
  mode "755"
  source "update_hostname"
end

cookbook_file "/usr/local/chronus/lib/mysql_helper.rb" do
  source "mysql_helper.rb"
  owner "root"
  group "root"
  mode "644"
end

cookbook_file "/usr/local/chronus/lib/s3_helper.rb" do
  source "s3_helper.rb"
  owner "root"
  group "root"
  mode "644"
end

cookbook_file "/usr/local/chronus/lib/utils.rb" do
  source "utils.rb"
  owner "root"
  group "root"
  mode "644"
end

execute "Updating the host name to public" do  
  command "/usr/local/chronus/bin/update_hostname"
end


# Deploy specific setup
deploy_user = node.default[:ivin_application][:deploy_user]
file "/home/#{deploy_user}/.ssh/id_rsa"  do
    owner deploy_user
    group deploy_user
    mode "600"
    content deploy_keys["id-rsa"]
end

file "/home/#{deploy_user}/.ssh/id_rsa.pub" do 
  owner deploy_user
  group deploy_user
  mode "644"
  content deploy_keys["id-rsa.pub"]
end

cookbook_file "/home/#{deploy_user}/.ssh/config" do
  source "ssh_config"
  owner deploy_user
  group deploy_user
end

cookbook_file "/usr/local/chronus/bin/pull_ssh_keys.rb" do
  source "pull_ssh_keys.rb"
  owner "root"
  group "root"
  mode "755"
end

cookbook_file "/usr/local/chronus/bin/cron_for_tddium_branches.rb" do
  source "cron_for_tddium_branches.rb"
  owner "app"
  group "app"
  mode "755"
end

template "/usr/local/chronus/bin/cred_details.yml" do
  variables(:AWSAccessKeyId => aws_data['access_key'],:AWSSecretKey => aws_data['secret_key'] )
  mode 0644
  owner "root"
  group "root"
  source "cred_details.yml.erb"
end

file Chef::Config[:validation_key] do
    action :delete
    backup false
    only_if { ::File.exists?(Chef::Config[:client_key]) }
end

cookbook_file "/usr/local/chronus/bin/mysql-ssl-ca-cert.pem" do
  source "mysql-ssl-ca-cert"
  owner "app"
  group "app"
  mode "640"
end