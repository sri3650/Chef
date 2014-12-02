current_dir = File.dirname(__FILE__)

require 'net/http'
require 'chef'

Chef::Config.from_file(File.join(current_dir, '.chef', 'knife.rb'))

bagname = ARGV[0]
itemname = ARGV[1]
key = ARGV[2]
output_path = ARGV[3]
encrypted_data_path = ARGV[4]

if Chef::DataBag.list.keys.include?(bagname)
  secret = Chef::EncryptedDataBagItem.load_secret(encrypted_data_path)
  value = Chef::EncryptedDataBagItem.load(bagname, itemname, secret)
  output = value[key].gsub(/\\n/) {|match| "\n"}
  File.open(output_path, "w") do |file|
    file.write output
  end
else
  puts "Databag not present. Please create the databag"
end