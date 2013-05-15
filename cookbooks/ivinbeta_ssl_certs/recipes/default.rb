#
# Cookbook Name:: ivinbeta_ssl_certs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ssl_cert_path = node.default[:patent_db_application][:ssl_certificate_path]
execute "Create the ssl private directory" do
  command "mkdir -p #{ssl_cert_path}/private/ && chown root:root #{ssl_cert_path}/private/"  
  not_if { ::File.exists?("#{ssl_cert_path}/private/") }
end

execute "Create the ssl cert directory" do
  command "mkdir -p #{ssl_cert_path}/cert/ && chown root:root #{ssl_cert_path}/cert/"  
  not_if { ::File.exists?("#{ssl_cert_path}/cert/") }
end

cookbook_file "#{ssl_cert_path}/cert/ivinbeta.intven.com.crt" do
  source "ivinbeta.intven.com.crt"
  mode "644"
  # not_if { ::File.exists?("#{ssl_cert_path}/cert/ivinbeta.intven.com.crt") } ask arun
end

cookbook_file "#{ssl_cert_path}/private/ivinbeta.key" do
  source "ivinbeta.key"
  mode "644"
  # not_if { ::File.exists?("#{ssl_cert_path}/private/ivinbeta.key") } ask arun
end