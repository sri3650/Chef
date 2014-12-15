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
 content ssl_certs["ivin_com_crt"]
  mode "644"
end

file "#{ssl_cert_path}/private/ivin_#{node.chef_environment}.key" do
  content ssl_certs["ivin_key"]
  mode "644"
end

file "#{ssl_cert_path}/cert/#{node[:ivin_application][:sellers_server_name]}.crt" do
  content ssl_certs["sellers_com_crt"]
  mode "644"
end

file "#{ssl_cert_path}/private/sellers_#{node.chef_environment}.key" do
  content ssl_certs["sellers_key"]
  mode "644"
end

file "#{ssl_cert_path}/cert/#{node[:ivin_application][:idf_server_name]}.crt" do
  content ssl_certs["idf_com_crt"]
  mode "644"
end

file "#{ssl_cert_path}/private/idf_#{node.chef_environment}.key" do
  content ssl_certs["idf_key"]
  mode "644"
end

file "#{ssl_cert_path}/cert/#{node[:ivin_application][:iplab_server_name]}.crt" do
  content ssl_certs["iplab_com_crt"]
  mode "644"
end

file "#{ssl_cert_path}/private/iplab_#{node.chef_environment}.key" do
  content ssl_certs["iplab_key"]
  mode "644"
end