#
# Cookbook Name:: passenger
# Recipe:: production

include_recipe "passenger::install"

package "curl"
if ['ubuntu', 'debian'].member? node[:platform]
  ['libcurl4-openssl-dev','libpcre3-dev'].each do |pkg|
    package pkg
  end
end

nginx_path = node[:passenger][:path]
nginx_log_path = node[:passenger][:nginx_log_path]
tuned_ruby_path = node[:passenger][:tuned_ruby_path]

template "/usr/local/bin/ruby_tuned" do
  source "ruby_tuned.erb"
  owner "root"
  group "root"
  mode 0755
  variables(
    :ruby_heap_min_slots => node[:passenger][:ruby_heap_min_slots],
    :ruby_heap_free_min => node[:passenger][:ruby_heap_free_min],
    :ruby_heap_slots_increment => node[:passenger][:ruby_heap_slots_increment],
    :ruby_heap_slots_growth_factor => node[:passenger][:ruby_heap_slots_growth_factor],
    :ruby_gc_malloc_limit => node[:passenger][:ruby_gc_malloc_limit]
  )
end

bash "install passenger/nginx" do
  user "root"
  code <<-EOH
  passenger-install-nginx-module --auto --auto-download --prefix="#{nginx_path}" --extra-configure-flags="#{node[:passenger][:configure_flags]}"
  EOH
  not_if "test -e #{nginx_path}"
  not_if "test -e /usr/local/rvm"
end

bash "install passenger/nginx from rvm" do
  user "root"
  code <<-EOH
  /usr/local/bin/rvm exec passenger-install-nginx-module --auto --auto-download --prefix="#{nginx_path}" --extra-configure-flags="#{node[:passenger][:configure_flags]}"
  EOH
  not_if "test -e #{nginx_path}"
  only_if "test -e /usr/local/rvm"
end

log_path = node[:passenger][:log_path]

directory log_path do
  mode 0755
  action :create
end

directory nginx_log_path do
  mode 0755
  action :create
end

directory "#{nginx_path}/conf/conf.d" do
  mode 0755
  action :create
  recursive true
  notifies :reload, 'service[passenger]'
end

directory "#{nginx_path}/conf/sites.d" do
  mode 0755
  action :create
  recursive true
  notifies :reload, 'service[passenger]'
end

cookbook_file "#{nginx_path}/sbin/config_patch.sh" do
  owner "root"
  group "root"
  mode 0755
end

template "/etc/init.d/passenger" do
  source "passenger.init.erb"
  owner "root"
  group "root"
  mode 0755
  variables(
    :pidfile => "#{nginx_path}/logs/nginx.pid",
    :nginx_path => nginx_path
  )
end

if node[:passenger][:status_server]
  cookbook_file "#{nginx_path}/conf/sites.d/status.conf" do
    source "status.conf"
    mode "0644"
  end
end

service "passenger" do
  service_name "passenger"
  reload_command "#{nginx_path}/sbin/nginx -s reload"
  start_command "#{nginx_path}/sbin/nginx"
  stop_command "#{nginx_path}/sbin/nginx -s stop"
  status_command "curl http://localhost/nginx_status"
  supports [ :start, :stop, :reload, :status, :enable ]
  action [ :enable, :start ]
  pattern "nginx: master"
end
