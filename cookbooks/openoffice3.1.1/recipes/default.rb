#
# Cookbook Name:: openoffice3.1.1
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

tar_file = "OOo_3.1.1_LinuxX86-64_install_en-US_deb.tar.gz"
execute "download openoffice3.1.1 tar file" do
  cwd "/tmp"
  command "wget ftp://ftp.rz.tu-bs.de/pub/mirror/openoffice-archive/stable/3.1.1/#{tar_file}"
  not_if { ::File.exists?("/tmp/#{tar_file}") } # the file's kinda big
end

execute "Extract openoffice source" do
  cwd "/tmp"
  command "tar -zxvf /tmp/#{tar_file}"
  not_if { ::File.exists?("/tmp/OOO310_m19_native_packed-2_en-US.9420") }
end

execute "install all debian packages" do
  cwd "/tmp/OOO310_m19_native_packed-2_en-US.9420/DEBS"
  command "sudo dpkg -i *.deb"
  not_if "dpkg --get-selections | grep openoffice | grep -v openoffice.org-debian-menus"
end

execute "install desktop integration packages" do
  cwd "/tmp/OOO310_m19_native_packed-2_en-US.9420/DEBS/desktop-integration"
  command "sudo dpkg -i *.deb"
  not_if "dpkg --get-selections | grep openoffice.org-debian-menus"
end

headless_file = "openoffice.org-headless-3.1.1-19.14.fc12.x86_64.rpm"
headless_file_debian = "openoffice.org-headless_3.1.1-19.14.fc12_amd64.deb"
execute "download openoffice headless file" do
  cwd "/tmp"
  command "wget ftp://ftp.pbone.net/mirror/archive.fedoraproject.org/fedora/linux/releases/12/Everything/x86_64/os/Packages/#{headless_file}"
  not_if { ::File.exists?("/tmp/#{headless_file}") }
end

execute "convert rpm to a deb file" do
  cwd "/tmp"
  command "sudo alien -k #{headless_file}"
  not_if { ::File.exists?("/tmp/#{headless_file_debian}") }
end

execute "install headless package" do
  cwd "/tmp"
  command "sudo dpkg -i #{headless_file_debian}"
  not_if "dpkg --get-selections | grep openoffice.org-headless"
end