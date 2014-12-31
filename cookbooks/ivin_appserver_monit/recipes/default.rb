#
# Cookbook Name:: ivin_appserver_monit
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# build monitrc files (Add new file in the templates and then include it in the attribute 'processes')
node.default[:ivin_appserver_monit][:processes].each do |process|
  monitrc process
end

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
