#!/usr/bin/env ruby
exit unless File.exists?("/mnt/app/current")

require "rubygems"
require "optiflag"
require "#{File.dirname(__FILE__)}/../lib/mysql_helper"

module CommandLineArgs extend OptiFlagSet
  optional_flag "name"
  optional_switch_flag "reset"
  and_process!
end

name = ARGV.flags.name
@mysql = Ec2onrails::MysqlHelper.new
@temp_dir = "/mnt/tmp/capistrano_dumps/"
file = "#{@temp_dir}/#{name}.sql.gz"

FileUtils.mkdir_p @temp_dir

@mysql.dump(file, ARGV.flags.reset)