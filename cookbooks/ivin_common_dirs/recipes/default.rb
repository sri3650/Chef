#
# Cookbook Name:: ivin_common_dirs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
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