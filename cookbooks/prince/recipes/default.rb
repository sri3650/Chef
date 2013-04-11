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


arch =
  case node[:kernel][:machine]
  when "x86_64" then "amd64"
  else node[:kernel][:machine]
  end

sums = {
  "amd64" => "96691f7240ba0eb13ee7105d95a99aa8fdd31223c50d39656970f758c823ccd1",
  "i386" => "43b60fe39123de2a0e7653128dc27e1f2943b0db38dcdb56e28e7c9cca1ff6a3",
}

file = "prince_8.0-1ubuntu10.04_#{arch}.deb"
remote_file "/tmp/#{file}" do
  source "http://www.princexml.com/download/#{file}"
  mode "0644"
  checksum sums[arch]
  action :create_if_missing # the file's kinda big
end


# required by Prince
package "libgif4"
package "libtiff4"
package "libfontconfig1"
package "libcurl3"

dpkg_package "prince" do
  source "/tmp/#{file}"
  action :install
end

cookbook_file "/usr/lib/prince/license/license.dat" do
  source "license.dat"
  owner "root"
  group "root"
  mode "644"
end


#FONTS for PRINCE

package "ttf-mscorefonts-installer" do
  action :install
end

execute "Create the fonts directory" do
  command "mkdir -p /home/app/.fonts && chown app:app /home/app/.fonts"
  not_if { ::File.exists?("/home/app/.fonts") }
end

#copying some fonts to this folder has to be done. punted for now
execute "Download necessary fonts from s3" do
  cwd "/home/app/.fonts"
  command "s3cmd get #{node.default[:prince][:s3_font_path]}/#{node.default[:prince][:font_files][0]} --skip-existing"
end

execute "Download necessary fonts from s3 - 1" do
  cwd "/home/app/.fonts"
  command "s3cmd get #{node.default[:prince][:s3_font_path]}/#{node.default[:prince][:font_files][1]} --skip-existing"
end

execute "Download necessary fonts from s3 - 2" do
  cwd "/home/app/.fonts"
  command "s3cmd get #{node.default[:prince][:s3_font_path]}/#{node.default[:prince][:font_files][2]} --skip-existing"
end

cookbook_file "/usr/lib/prince/style/ivin_fonts.css" do
  source "ivin_fonts.css"
  owner "root"
  group "root"
  mode "644"
end