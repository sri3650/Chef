#!/usr/bin/ruby

require "rubygems"
require "optiflag"
require "fileutils"
require "#{File.dirname(__FILE__)}/../lib/s3_helper"

module CommandLineArgs extend OptiFlagSet
  optional_flag "bucket"
  optional_flag "file"
  and_process!
end

bucket = ARGV.flags.bucket || "ivin-ops"
file_name = ARGV.flags.file || "authorized_keypairs"
current_user = ENV['USER']

begin
  # Retrive keyfile from S3
  s3 = Ec2onrails::S3Helper.new(bucket, nil)
  temp_dir = "/mnt/tmp/ssh_keys_#{current_user}"
  FileUtils.mkdir_p temp_dir
  temp_file = "#{temp_dir}/#{file_name}"
  puts "S3 Bucket : #{s3.bucket}"
  puts "S3 File to be retrieved : #{s3.s3_key(temp_file)}"
  s3.retrieve_file(temp_file)
  puts "Retrieved file as #{temp_file}"

  # Rotate Keys
  begin
    keys_file = current_user == "root" ? "/root/.ssh/authorized_keys" : "/home/#{current_user}/.ssh/authorized_keys"
    backup_keys_file = "#{keys_file}.backup_#{Time.now.to_i}"

    # Backing up old keys file
    puts "Backing up..."
    FileUtils.mv(keys_file, backup_keys_file) if File.exist?(keys_file)
    puts "Success!"

    # Copying downloaded keys file
    puts "Copying file..."
    FileUtils.cp(temp_file, keys_file)
    puts "Success!"

    puts "Setting File Permissions..."
    FileUtils.chmod(0600, keys_file)
    puts "Success!"

    # Removing Backup
    puts "Removing Backup Files..."
    FileUtils.rm(backup_keys_file) if File.exist?(backup_keys_file)
    puts "Success!"
  rescue Exception => ex
    # Rolling back if exception occurred
    puts "Rolling Back..."
    FileUtils.mv(backup_keys_file, keys_file) if File.exist?(backup_keys_file)
    puts "Success!"
    raise ex
  end
  puts "Sync Complete."
ensure
  FileUtils.rm_rf(temp_dir)
end
