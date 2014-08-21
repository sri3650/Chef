#
# Cookbook Name:: ivin_ssl_certs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ssl_cert_path = node.default[:ivin_application][:ssl_certificate_path]
execute "Create the ssl private directory" do
  command "mkdir -p #{ssl_cert_path}/private/ && chown root:root #{ssl_cert_path}/private/"  
  not_if { ::File.exists?("#{ssl_cert_path}/private/") }
end

execute "Create the ssl cert directory" do
  command "mkdir -p #{ssl_cert_path}/cert/ && chown root:root #{ssl_cert_path}/cert/"  
  not_if { ::File.exists?("#{ssl_cert_path}/cert/") }
end

secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
ssl_certs = Chef::EncryptedDataBagItem.load("ssl_certs", "#{node.chef_environment}", secret)


file "#{ssl_cert_path}/cert/#{node[:ivin_application][:server_name]}.crt" do
  # variables(:ivin_com_crt => ssl_certs["ivin_com_crt"])
  # source "ssl_credentials/ivin.server_name.crt.erb"
 content ssl_certs["ivin_com_crt"]
  mode "644"
end

file "#{ssl_cert_path}/private/ivin_#{node.chef_environment}.key" do
  # variables(:ivin_key => ssl_certs["ivin_key"])
  # source "ssl_credentials/ivin.key.erb"
  content ssl_certs["ivin_key"]
  mode "644"
end

file "#{ssl_cert_path}/cert/#{node[:ivin_application][:sellers_server_name]}.crt" do
 # variables(:sellers_com_crt => ssl_certs["sellers_com_crt"])
 #  source "ssl_credentials/sellers.server_name.crt.erb"
  content ssl_certs["sellers_com_crt"]
  mode "644"
end

file "#{ssl_cert_path}/private/sellers_#{node.chef_environment}.key" do
  # variables(:sellers_key => ssl_certs["sellers_key"])
  # source "ssl_credentials/sellers.key.erb"
  content ssl_certs["sellers_key"]
  mode "644"
end

file "#{ssl_cert_path}/cert/#{node[:ivin_application][:idf_server_name]}.crt" do
  # variables(:idf_com_crt => ssl_certs["idf_com_crt"])
  # source "ssl_credentials/idf.server_name.crt.erb"
  content ssl_certs["idf_com_crt"]
  mode "644"
end

file "#{ssl_cert_path}/private/idf_#{node.chef_environment}.key" do
  # variables(:idf_key => ssl_certs["idf_key"])
  # source "ssl_credentials/idf.key.erb"
  content ssl_certs["idf_key"]
  mode "644"
end