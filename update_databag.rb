current_dir = File.dirname(__FILE__)

require 'net/http'
require 'chef'

Chef::Config.from_file(File.join(current_dir, '.chef', 'knife.rb'))

bagname = ARGV[0]
itemname = ARGV[1]
key = ARGV[2]
file_path = ARGV[3]
encrypted_data_path = ARGV[4]

if Chef::DataBag.list.keys.include?(bagname)
  value = open(file_path).read.gsub(/\n/) {|match| "\\n"}
  secret = Chef::EncryptedDataBagItem.load_secret(encrypted_data_path)
  item = Chef::DataBagItem.load(bagname, itemname)
  item[key] = value
  encrypted_hash = Chef::EncryptedDataBagItem.encrypt_data_bag_item(item, secret)
  item[key] = encrypted_hash[key]
  item.save
else
  puts "Databag not present. Please create the databag"
end