#!/usr/bin/env ruby


exit unless File.exists?("/mnt/app/current")

require 'rubygems'
require 'rest-client'
require 'time'
require 'uri'
require 'json'
require "optiflag"
require "fileutils"
require 'yaml'
require 'erb'
require "#{File.dirname(__FILE__)}/../lib/s3_helper"
require "#{File.dirname(__FILE__)}/../lib/utils"

NUM_OF_RETRY = 3
HOST_BASE_URI = "api.mailgun.net"
CONFIG_FILE = "/mnt/app/current/config/credentials.yml"
RETRY_ALLOWED_RESPONSES = [402, 500, 502, 503, 504]
DOMAIN = "<%= node[:ivin_application][:mailgun_domain_name] %>"
DEFAULT_URI_PATH = "/v2/chronus.com/events"

module CommandLineArgs extend OptiFlagSet
  optional_flag "bucket"
  optional_flag "dir"
  optional_flag "name"
  optional_switch_flag "notify"
  and_process!
end

def get_mailgun_key
  config_file = YAML::load(ERB.new(File.read(CONFIG_FILE)).result)
  config_file[Ec2onrails::Utils.rails_env]["mail_mailgun_api_key"]
end

API_KEY = get_mailgun_key

#Sample json response given by mailgun
# {
#   "items": [
#     {
#       "tags": [],
#       "timestamp": 1376325780.160809,
#       "envelope": {
#         "sender": "me@samples.mailgun.org",
#         "transport": ""
#       },
#       "event": "accepted",
#       "campaigns": [],
#       "user-variables": {},
#       "flags": {
#         "is-authenticated": true,
#         "is-test-mode": false
#       },
#       "message": {
#         "headers": {
#           "to": "user@example.com",
#           "message-id": "20130812164300.28108.52546@samples.mailgun.org",
#           "from": "Excited User <me@samples.mailgun.org>",
#           "subject": "Hello"
#         },
#         "attachments": [],
#         "recipients": [
#           "user@example.com"
#         ],
#         "size": 69
#       },
#       "recipient": "user@example.com",
#       "method": "http"
#     }
#   ],
#   "paging": {
#     "next":
#         "https://api.mailgun.net/v2/samples.mailgun.org/events/W3siY...",
#     "previous":
#         "https://api.mailgun.net/v2/samples.mailgun.org/events/Lkawm..."
#   }
# }

def get_page(log_page_uri, parameters = {})
  trial = 0
  begin
    json_log = RestClient.get log_page_uri, parameters
    return JSON.parse(json_log)
  rescue RestClient::Exception => e
    if RETRY_ALLOWED_RESPONSES.include?(e.response.code) && trial < NUM_OF_RETRY
      trial += 1
      sleep(5)
      retry
    else
      raise e
    end
  end
end

def log_page_uri(path)
  "https://api:#{API_KEY}@#{HOST_BASE_URI}#{path}"
end

def get_logs(begin_time, end_time, log_file)
  parameter_list = {:begin => begin_time, :end => end_time, :pretty => 'yes'}
  json_log_hash = get_page(log_page_uri(DEFAULT_URI_PATH), :params => parameter_list)
  File.open(log_file, "wb") do |file|
    until json_log_hash["items"].empty?
      file.puts(json_log_hash["items"])
      json_log_hash = get_page(log_page_uri(URI(json_log_hash["paging"]["next"]).path))
    end
  end
end

def compress_log_file(file_name)
  unless system "gzip #{file_name}"
   raise "Cannot compress the file: #{file_name}"
  else
    return "#{file_name}.gz"
  end
end

bucket = ARGV.flags.bucket
notify_flag = ARGV.flags.notify?
dir = ARGV.flags.dir || "logs/mailgun"
name = ARGV.flags.name || "mailgun_log"

temp_log_file = "/tmp/#{name}_#{Time.now.strftime("%Y%m%d")}"

#end_time - time upto which event logs to be downloaded
#begin_time - time from which event logs to be downlaoded
LOG_TIME = {:hour => 5, :min => 0}
end_time = Time.now.utc
end_time = Time.utc(end_time.year, end_time.month, end_time.day, LOG_TIME[:hour], LOG_TIME[:min])
begin_time = end_time - 60 * 60 * 24

begin
  get_logs(begin_time.rfc2822, end_time.rfc2822, temp_log_file)
  @s3 = Ec2onrails::S3Helper.new(bucket, dir)
  temp_log_file = compress_log_file(temp_log_file)
  @s3.store_file temp_log_file
rescue => e
  puts e
  puts e.backtrace
  if notify_flag
    subject = "Error: Mailgun Log Retention, #{Time.now.utc}"
    message = "#{e.message} #{e.backtrace}"
    puts message
    `echo "#{message.gsub(/[`;\"]/,"'")}" | /mnt/app/current/script/emergency_mail_sender.rb "#{subject}"`
  end
ensure
  FileUtils.rm_rf(temp_log_file)
end
