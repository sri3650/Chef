#
# Cookbook Name:: ivin_users
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
aws_data = Chef::EncryptedDataBagItem.load("aws", "creds", secret)
user_keys = Chef::EncryptedDataBagItem.load("ssh_keys", "user_specific_keys", secret)

ubuntu_public_key_file = "/home/ubuntu/.ssh/authorized_keys"

group "app" do
end

%w{app admin}.each do |u|
  home_dir = "/home/#{u}"

  user u do
    gid u
    comment u
    supports :manage_home => true
    home home_dir
  end

  directory "#{home_dir}/.ssh" do
    owner u
    group u
    mode "0700"
  end

  file "#{home_dir}/.ssh/authorized_keys" do
    owner u
    group u
    mode "0600"
    content user_keys[u]
  end

  cookbook_file "#{home_dir}/.bashrc" do
    source "bashrc"
    owner u
    group u
    mode "0644"
  end  
end

file "/root/.ssh/authorized_keys" do
  owner 'root'
  group 'root'
  mode "0600"
  content IO.read(ubuntu_public_key_file)
end

cookbook_file "/root/.bashrc" do
  source "bashrc"
  owner 'root'
  group 'root'
  mode '0644'
end

template "/root/.awssecret" do
  variables(:AWSAccessKeyId => aws_data['access_key'],:AWSSecretKey => aws_data['secret_key'])
   mode 0644
  owner "root"
  group "root"
  source "awssecret.erb"
end

template "/etc/sudoers" do
  source "sudoers.erb"
  mode 0440
  owner "root"
  group "root"
  variables(
    :sudoers_groups => node[:authorization][:sudo][:groups],
    :sudoers_users => node[:authorization][:sudo][:users],
    :passwordless => true
  )
end