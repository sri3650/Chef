current_dir = File.dirname(__FILE__)

require 'net/http'
require 'chef'

Chef::Config.from_file(File.join(current_dir, '.chef', 'knife.rb'))

# eg: CHEF_ENV='staging' ruby get_databag_item_value.rb databag databag_item databag_key path_of_output_file path_to_encrypted_databag_file

bagname = ARGV[0] # databag name
itemname = ARGV[1] # databag item name
key = ARGV[2] # key for databag item
output_path = ARGV[3] # output file to store the value
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