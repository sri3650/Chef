#
# Cookbook Name:: prince
# Recipe:: default
#
# Copyright 2011, O'Reilly Media, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
princeLicense = Chef::EncryptedDataBagItem.load("prince_license", "license", secret)
package_directory = node[:ivin_application][:packages_directory]
arch =
  case node[:kernel][:machine]
  when "x86_64" then "amd64"
  else node[:kernel][:machine]
  end

sums = {
  "amd64" => "96691f7240ba0eb13ee7105d95a99aa8fdd31223c50d39656970f758c823ccd1",
  "i386" => "43b60fe39123de2a0e7653128dc27e1f2943b0db38dcdb56e28e7c9cca1ff6a3",
}

file = "prince_7.2-4ubuntu10.04_#{arch}.deb"
remote_file "#{package_directory}/#{file}" do
  source "http://www.princexml.com/download/#{file}"
  mode "0644"
  checksum sums[arch]
  action :create_if_missing
end


# required by Prince
package "libgif4"
package "libtiff4"
package "libfontconfig1"
package "libcurl3"
package "libjpeg62"
package "libssl0.9.8"

dpkg_package "prince" do
  source "#{package_directory}/#{file}"
  action :install
end
template "/usr/lib/prince/license/license.dat" do
    variables(:license_id => princeLicense["license_id"],
             :license_signature => princeLicense["license_signature"])
   owner "root"
    group "root"
    mode "644"
    source "license.dat.erb"
end


#FONTS for PRINCE

execute "install msttcorefonts for prince" do
  command "echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections"
  #have to introduce a not if. not critical though TODO 
end

package "ttf-mscorefonts-installer" do
  action :install
end

execute "Create the fonts directory" do
  command "mkdir -p /home/app/.fonts && chown app:app /home/app/.fonts"
  not_if { ::File.exists?("/home/app/.fonts") }
end

node.default[:prince][:font_files].each do |font_file|
  execute "Download #{font_file} font from s3" do
    cwd "/home/app/.fonts"
    command "s3cmd get #{node.default[:prince][:s3_font_path]}/#{font_file} --skip-existing"
    not_if { ::File.exists?("/home/app/.fonts/#{font_file}") }
  end
end

cookbook_file "/usr/lib/prince/style/fonts.css" do
  source "ivin_fonts.css"
  owner "root"
  group "root"
  mode "644"
end