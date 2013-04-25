#
# Cookbook Name:: mysql
# Attributes:: server
#
# Copyright 2008-2009, Opscode, Inc.
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

default['ivin_mysql']['bind_address']               = '127.0.0.1'
default['ivin_mysql']['port']                       = 3306
default['ivin_mysql']['nice']                       = 0
default['ivin_mysql']['server_debian_password']     = ''
default['ivin_mysql']['server_root_password']       = ''
default['ivin_mysql']['server_repl_password']       = ''

case node["platform_family"]
when "debian"
  default['ivin_mysql']['server']['packages']      = %w{mysql-server}
  default['ivin_mysql']['service_name']            = "mysql"
  default['ivin_mysql']['basedir']                 = "/usr"
  default['ivin_mysql']['data_dir']                = "/var/lib/mysql"
  default['ivin_mysql']['root_group']              = "root"
  default['ivin_mysql']['mysqladmin_bin']          = "/usr/bin/mysqladmin"
  default['ivin_mysql']['mysql_bin']               = "/usr/bin/mysql"

  default['ivin_mysql']['conf_dir']                    = '/etc/mysql'
  default['ivin_mysql']['confd_dir']                   = '/etc/mysql/conf.d'
  default['ivin_mysql']['socket']                      = "/var/run/mysqld/mysqld.sock"
  default['ivin_mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  default['ivin_mysql']['old_passwords']               = 0
  default['ivin_mysql']['grants_path']                 = "/etc/mysql/grants.sql"
when "rhel", "fedora", "suse"
  if node["mysql"]["version"].to_f >= 5.5
    default['ivin_mysql']['service_name']            = "mysql"
    default['ivin_mysql']['pid_file']                    = "/var/run/mysql/mysql.pid"
  else
    default['ivin_mysql']['service_name']            = "mysqld"
    default['ivin_mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  end
  default['ivin_mysql']['server']['packages']      = %w{mysql-server}
  default['ivin_mysql']['basedir']                 = "/usr"
  default['ivin_mysql']['data_dir']                = "/var/lib/mysql"
  default['ivin_mysql']['root_group']              = "root"
  default['ivin_mysql']['mysqladmin_bin']          = "/usr/bin/mysqladmin"
  default['ivin_mysql']['mysql_bin']               = "/usr/bin/mysql"

  default['ivin_mysql']['conf_dir']                    = '/etc'
  default['ivin_mysql']['confd_dir']                   = '/etc/mysql/conf.d'
  default['ivin_mysql']['socket']                      = "/var/lib/mysql/mysql.sock"
  default['ivin_mysql']['old_passwords']               = 1
  default['ivin_mysql']['grants_path']                 = "/etc/mysql_grants.sql"
  # RHEL/CentOS mysql package does not support this option.
  default['ivin_mysql']['tunable']['innodb_adaptive_flushing'] = false
when "freebsd"
  default['ivin_mysql']['server']['packages']      = %w{mysql55-server}
  default['ivin_mysql']['service_name']            = "mysql-server"
  default['ivin_mysql']['basedir']                 = "/usr/local"
  default['ivin_mysql']['data_dir']                = "/var/db/mysql"
  default['ivin_mysql']['root_group']              = "wheel"
  default['ivin_mysql']['mysqladmin_bin']          = "/usr/local/bin/mysqladmin"
  default['ivin_mysql']['mysql_bin']               = "/usr/local/bin/mysql"

  default['ivin_mysql']['conf_dir']                    = '/usr/local/etc'
  default['ivin_mysql']['confd_dir']                   = '/usr/local/etc/mysql/conf.d'
  default['ivin_mysql']['socket']                      = "/tmp/mysqld.sock"
  default['ivin_mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  default['ivin_mysql']['old_passwords']               = 0
  default['ivin_mysql']['grants_path']                 = "/var/db/mysql/grants.sql"
when "windows"
  default['ivin_mysql']['server']['packages']      = ["MySQL Server 5.5"]
  default['ivin_mysql']['version']                 = '5.5.21'
  default['ivin_mysql']['arch']                    = 'win32'
  default['ivin_mysql']['package_file']            = "mysql-#{mysql['version']}-#{mysql['arch']}.msi"
  default['ivin_mysql']['url']                     = "http://www.mysql.com/get/Downloads/MySQL-5.5/#{mysql['package_file']}/from/http://mysql.mirrors.pair.com/"

  default['ivin_mysql']['service_name']            = "mysql"
  default['ivin_mysql']['basedir']                 = "#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\MySQL\\#{mysql['server']['packages'].first}"
  default['ivin_mysql']['data_dir']                = "#{node['mysql']['basedir']}\\Data"
  default['ivin_mysql']['bin_dir']                 = "#{node['mysql']['basedir']}\\bin"
  default['ivin_mysql']['mysqladmin_bin']          = "#{node['mysql']['bin_dir']}\\mysqladmin"
  default['ivin_mysql']['mysql_bin']               = "#{node['mysql']['bin_dir']}\\mysql"

  default['ivin_mysql']['conf_dir']                = node['mysql']['basedir']
  default['ivin_mysql']['old_passwords']           = 0
  default['ivin_mysql']['grants_path']             = "#{node['mysql']['conf_dir']}\\grants.sql"
when "mac_os_x"
  default['ivin_mysql']['server']['packages']      = %w{mysql}
  default['ivin_mysql']['basedir']                 = "/usr/local/Cellar"
  default['ivin_mysql']['data_dir']                = "/usr/local/var/mysql"
  default['ivin_mysql']['root_group']              = "admin"
  default['ivin_mysql']['mysqladmin_bin']          = "/usr/local/bin/mysqladmin"
  default['ivin_mysql']['mysql_bin']               = "/usr/local/bin/mysql"
else
  default['ivin_mysql']['server']['packages']      = %w{mysql-server}
  default['ivin_mysql']['service_name']            = "mysql"
  default['ivin_mysql']['basedir']                 = "/usr"
  default['ivin_mysql']['data_dir']                = "/var/lib/mysql"
  default['ivin_mysql']['root_group']              = "root"
  default['ivin_mysql']['mysqladmin_bin']          = "/usr/bin/mysqladmin"
  default['ivin_mysql']['mysql_bin']               = "/usr/bin/mysql"

  default['ivin_mysql']['conf_dir']                    = '/etc/mysql'
  default['ivin_mysql']['confd_dir']                   = '/etc/mysql/conf.d'
  default['ivin_mysql']['socket']                      = "/var/run/mysqld/mysqld.sock"
  default['ivin_mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  default['ivin_mysql']['old_passwords']               = 0
  default['ivin_mysql']['grants_path']                 = "/etc/mysql/grants.sql"
end

if attribute?('ec2')
  default['ivin_mysql']['ec2_path']    = "/mnt/mysql"
  default['ivin_mysql']['ebs_vol_dev'] = "/dev/sdi"
  default['ivin_mysql']['ebs_vol_size'] = 50
end

default['ivin_mysql']['reload_action'] = "restart" # or "reload" or "none"

default['ivin_mysql']['use_upstart'] = node['platform'] == "ubuntu" && node['platform_version'].to_f >= 10.04

default['ivin_mysql']['auto-increment-increment']        = 1
default['ivin_mysql']['auto-increment-offset']           = 1

default['ivin_mysql']['allow_remote_root']               = false
default['ivin_mysql']['tunable']['character-set-server'] = "utf8"
default['ivin_mysql']['tunable']['collation-server']     = "utf8_general_ci"
default['ivin_mysql']['tunable']['back_log']             = "128"
default['ivin_mysql']['tunable']['key_buffer']           = "64M"
default['ivin_mysql']['tunable']['key_buffer_size']           = "16M"
default['ivin_mysql']['tunable']['myisam_sort_buffer_size']   = "8M"
default['ivin_mysql']['tunable']['myisam_max_sort_file_size'] = "2147483648"
default['ivin_mysql']['tunable']['myisam_repair_threads']     = "1"
default['ivin_mysql']['tunable']['myisam_recover']            = "BACKUP"
default['ivin_mysql']['tunable']['max_allowed_packet']   = "16M"
default['ivin_mysql']['tunable']['dump_max_allowed_packet']   = "16M"
default['ivin_mysql']['tunable']['max_connections']      = "100"
default['ivin_mysql']['tunable']['max_connect_errors']   = "10"
default['ivin_mysql']['tunable']['concurrent_insert']    = "2"
default['ivin_mysql']['tunable']['connect_timeout']      = "10"
default['ivin_mysql']['tunable']['tmp_table_size']       = "32M"
default['ivin_mysql']['tunable']['max_heap_table_size']  = node['mysql']['tunable']['tmp_table_size']
default['ivin_mysql']['tunable']['bulk_insert_buffer_size'] = node['mysql']['tunable']['tmp_table_size']
default['ivin_mysql']['tunable']['myisam_recover']       = "BACKUP"
default['ivin_mysql']['tunable']['net_read_timeout']     = "30"
default['ivin_mysql']['tunable']['net_write_timeout']    = "30"
default['ivin_mysql']['tunable']['table_cache']          = "64"
default['ivin_mysql']['tunable']['general_log_file']     = "/mnt/log/mysql/mysql.log"
default['ivin_mysql']['tunable']['general_log']          = "1"

default['ivin_mysql']['tunable']['thread_cache']         = "128"
default['ivin_mysql']['tunable']['thread_cache_size']    = 8
default['ivin_mysql']['tunable']['thread_concurrency']   = 10
default['ivin_mysql']['tunable']['thread_stack']         = "192K"
default['ivin_mysql']['tunable']['sort_buffer_size']     = "2M"
default['ivin_mysql']['tunable']['read_buffer_size']     = "128k"
default['ivin_mysql']['tunable']['read_rnd_buffer_size'] = "256k"
default['ivin_mysql']['tunable']['join_buffer_size']     = "128k"
default['ivin_mysql']['tunable']['wait_timeout']         = "180"
default['ivin_mysql']['tunable']['open-files-limit']     = "8192"
default['ivin_mysql']['tunable']['open-files']           = "1024"

default['ivin_mysql']['tunable']['sql_mode'] = nil

default['ivin_mysql']['tunable']['skip-character-set-client-handshake'] = false
default['ivin_mysql']['tunable']['skip-name-resolve']                   = false


default['ivin_mysql']['tunable']['server_id']                       = "1"
default['ivin_mysql']['tunable']['log_bin']                         = nil
default['ivin_mysql']['tunable']['log_bin_trust_function_creators'] = false

default['ivin_mysql']['tunable']['relay_log']                       = nil
default['ivin_mysql']['tunable']['relay_log_index']                 = nil
default['ivin_mysql']['tunable']['log_slave_updates']               = false

default['ivin_mysql']['tunable']['sync_binlog']                     = 0
default['ivin_mysql']['tunable']['skip_slave_start']                = false
default['ivin_mysql']['tunable']['read_only']                       = false

default['ivin_mysql']['tunable']['log_error']                       = "/mnt/log/mysql/error.log"
default['ivin_mysql']['tunable']['log_warnings']                    = false
default['ivin_mysql']['tunable']['log_queries_not_using_index']     = true
default['ivin_mysql']['tunable']['log_bin_trust_function_creators'] = false

default['ivin_mysql']['tunable']['innodb_log_file_size']            = "5M"
default['ivin_mysql']['tunable']['innodb_buffer_pool_size']         = "1204M"
default['ivin_mysql']['tunable']['innodb_buffer_pool_instances']    = "4"
default['ivin_mysql']['tunable']['innodb_additional_mem_pool_size'] = "20M"
default['ivin_mysql']['tunable']['innodb_data_file_path']           = "ibdata1:10M:autoextend"
default['ivin_mysql']['tunable']['innodb_flush_method']             = false
default['ivin_mysql']['tunable']['innodb_log_buffer_size']          = "8M"
default['ivin_mysql']['tunable']['innodb_write_io_threads']         = "4"
default['ivin_mysql']['tunable']['innodb_io_capacity']              = "200"
default['ivin_mysql']['tunable']['innodb_file_per_table']           = true
default['ivin_mysql']['tunable']['innodb_lock_wait_timeout']        = "50"
if node['cpu'].nil? or node['cpu']['total'].nil?
  default['ivin_mysql']['tunable']['innodb_thread_concurrency']       = "8"
  default['ivin_mysql']['tunable']['innodb_commit_concurrency']       = "8"
  default['ivin_mysql']['tunable']['innodb_read_io_threads']          = "8"
else
  default['ivin_mysql']['tunable']['innodb_thread_concurrency']       = "#{(Integer(node['cpu']['total'])) * 2}"
  default['ivin_mysql']['tunable']['innodb_commit_concurrency']       = "#{(Integer(node['cpu']['total'])) * 2}"
  default['ivin_mysql']['tunable']['innodb_read_io_threads']          = "#{(Integer(node['cpu']['total'])) * 2}"
end
default['ivin_mysql']['tunable']['innodb_flush_log_at_trx_commit']  = "1"
default['ivin_mysql']['tunable']['default-character-set']           =  "utf8"
default['ivin_mysql']['tunable']['innodb_support_xa']               = true
default['ivin_mysql']['tunable']['innodb_table_locks']              = true
default['ivin_mysql']['tunable']['skip-innodb-doublewrite']         = false

default['ivin_mysql']['tunable']['transaction-isolation'] = nil

default['ivin_mysql']['tunable']['query_cache_limit']    = "1M"
default['ivin_mysql']['tunable']['query_cache_size']     = "64M"

default['ivin_mysql']['tunable']['log_slow_queries']     = "/var/log/mysql/slow.log"
default['ivin_mysql']['tunable']['slow_query_log']       = node['mysql']['tunable']['log_slow_queries'] # log_slow_queries is deprecated
                                                                                                   # in favor of slow_query_log
default['ivin_mysql']['tunable']['long_query_time']      = 2

default['ivin_mysql']['tunable']['expire_logs_days']     = 10
default['ivin_mysql']['tunable']['max_binlog_size']      = "100M"
default['ivin_mysql']['tunable']['binlog_cache_size']    = "32K"

default['ivin_mysql']['tmpdir'] = ["/tmp"]
default['ivin_mysql']['language']  = "/usr/share/mysql/english"
default['ivin_mysql']['default-storage-engine'] = "InnoDB"
default['ivin_mysql']['read_only'] = false

default['ivin_mysql']['log_dir'] = node['mysql']['data_dir']
default['ivin_mysql']['log_files_in_group'] = false
default['ivin_mysql']['innodb_status_file'] = false

unless node['platform_family'] && node['platform_version'].to_i < 6
  # older RHEL platforms don't support these options
  default['ivin_mysql']['tunable']['event_scheduler']  = 0
  default['ivin_mysql']['tunable']['table_open_cache'] = "128"
  default['ivin_mysql']['tunable']['binlog_format']    = "statement" if node['mysql']['tunable']['log_bin']
end
