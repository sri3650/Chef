package "monit" do
  action :install
end

if platform?("ubuntu")
  cookbook_file "/etc/default/monit" do
    source "monit.default"
    owner "root"
    group "root"
    mode 0644
  end
end

service "monit" do
  action :nothing
  enabled true
  supports [:start, :restart, :stop]
end

template "/etc/monitrc" do
  owner "app"
  group "app"
  mode 0700
  source 'monitrc.erb'
end

directory "/etc/monit/conf.d/" do
  owner  'app'
  group 'app'
  mode 0755
  action :create
  recursive true
end

# We are source controlling the monit binary so that we can control the version. Default ubuntu apt-get repos may not have the 
# version we want. We download the monit binary from http://mmonit.com/monit/download/ (linux-x64 link)
cookbook_file "/usr/sbin/monit" do
  owner "root"
  group "root"
  mode 0755
  source 'monit'
end

# We tweak the default monit init script for the below reasons
# 1. Change the location of monitrc in the init script from /etc/monit/monitrc to /etc/monitrc
# 2. Skip monit start if the application has been deployed
cookbook_file "/etc/init.d/monit" do
  owner "root"
  group "root"
  mode 0755
  source 'init-monit'
end

monitrc "system"

# Donot start monit before cold deploy since there is nothing useful to monitor.
# After cold deploy is done we will bring it up and have it monitor.

 bash "monitor reload" do  
   code <<-EOH
     MONIT_PID=`ps -ef | grep 'monit' | grep 'app' | awk '{print $2}'`
     if [ ! -z $MONIT_PID ]; then
       echo "Issuing reload to monit process ( $MONIT_PID ) ..."
       sudo -u app monit reload
     else
       echo "monit not running : Skipping reload"
     fi
   EOH
 end
 