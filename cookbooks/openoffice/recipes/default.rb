#
# Cookbook Name:: openoffice
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

tar_source_file = "Apache_OpenOffice_incubating_3.4.1_Linux_x86-64_install-deb_en-US.tar.gz"
tar_file = "oo3.4.1.tar.gz"
tar_directory = "en-US"

execute "download openoffice tar file" do
  cwd "/tmp"
  command "curl -Lo #{tar_file} http://downloads.sourceforge.net/project/openofficeorg.mirror/stable/3.4.1/#{tar_source_file}"
  not_if { ::File.exists?("/tmp/#{tar_file}") } # the file's kinda big
end

execute "Extract openoffice source" do
  cwd "/tmp"
  command "tar -zxvf #{tar_file}"
  not_if { ::File.exists?("/tmp/#{tar_directory}") }
end

execute "install all debian packages" do
  cwd "/tmp/#{tar_directory}/DEBS"
  command "sudo dpkg -i *.deb"
  not_if "dpkg --get-selections | grep openoffice | grep -v openoffice.org-debian-menus"
end

execute "install desktop integration packages" do
  cwd "/tmp/#{tar_directory}/DEBS/desktop-integration"
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

execute "create fonts folder for openoffice" do
  cwd "/usr/local/share/fonts"
  command "mkdir -p truetype/Calibri"
  not_if { ::File.exists?("/usr/local/share/fonts/truetype/Calibri") }
end

node.default[:openoffice][:font_files].each do |font_file|
  execute "Download #{font_file} font from s3" do
    cwd "/usr/local/share/fonts/truetype/Calibri"
    command "s3cmd get #{node.default[:openoffice][:s3_font_path]}/#{font_file} --skip-existing"
    not_if { ::File.exists?("/usr/local/share/fonts/truetype/Calibri/#{font_file}") }
  end
end