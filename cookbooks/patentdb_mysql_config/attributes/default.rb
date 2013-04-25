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

default['pdb_mysql']['bind_address']               = '127.0.0.1'
default['pdb_mysql']['port']                       = 3306
default['pdb_mysql']['nice']                       = 0
default['pdb_mysql']['server_debian_password']     = ''
default['pdb_mysql']['server_root_password']       = ''
default['pdb_mysql']['server_repl_password']       = ''

case node["platform_family"]
when "debian"
  default['pdb_mysql']['server']['packages']      = %w{mysql-server}
  default['pdb_mysql']['service_name']            = "mysql"
  default['pdb_mysql']['basedir']                 = "/usr"
  default['pdb_mysql']['data_dir']                = "/var/lib/mysql"
  default['pdb_mysql']['root_group']              = "root"
  default['pdb_mysql']['mysqladmin_bin']          = "/usr/bin/mysqladmin"
  default['pdb_mysql']['mysql_bin']               = "/usr/bin/mysql"

  default['pdb_mysql']['conf_dir']                    = '/etc/mysql'
  default['pdb_mysql']['confd_dir']                   = '/etc/mysql/conf.d'
  default['pdb_mysql']['socket']                      = "/var/run/mysqld/mysqld.sock"
  default['pdb_mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  default['pdb_mysql']['old_passwords']               = 0
  default['pdb_mysql']['grants_path']                 = "/etc/mysql/grants.sql"
when "rhel", "fedora", "suse"
  if node["mysql"]["version"].to_f >= 5.5
    default['pdb_mysql']['service_name']            = "mysql"
    default['pdb_mysql']['pid_file']                    = "/var/run/mysql/mysql.pid"
  else
    default['pdb_mysql']['service_name']            = "mysqld"
    default['pdb_mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  end
  default['pdb_mysql']['server']['packages']      = %w{mysql-server}
  default['pdb_mysql']['basedir']                 = "/usr"
  default['pdb_mysql']['data_dir']                = "/var/lib/mysql"
  default['pdb_mysql']['root_group']              = "root"
  default['pdb_mysql']['mysqladmin_bin']          = "/usr/bin/mysqladmin"
  default['pdb_mysql']['mysql_bin']               = "/usr/bin/mysql"

  default['pdb_mysql']['conf_dir']                    = '/etc'
  default['pdb_mysql']['confd_dir']                   = '/etc/mysql/conf.d'
  default['pdb_mysql']['socket']                      = "/var/lib/mysql/mysql.sock"
  default['pdb_mysql']['old_passwords']               = 1
  default['pdb_mysql']['grants_path']                 = "/etc/mysql_grants.sql"
  # RHEL/CentOS mysql package does not support this option.
  default['pdb_mysql']['tunable']['innodb_adaptive_flushing'] = false
when "freebsd"
  default['pdb_mysql']['server']['packages']      = %w{mysql55-server}
  default['pdb_mysql']['service_name']            = "mysql-server"
  default['pdb_mysql']['basedir']                 = "/usr/local"
  default['pdb_mysql']['data_dir']                = "/var/db/mysql"
  default['pdb_mysql']['root_group']              = "wheel"
  default['pdb_mysql']['mysqladmin_bin']          = "/usr/local/bin/mysqladmin"
  default['pdb_mysql']['mysql_bin']               = "/usr/local/bin/mysql"

  default['pdb_mysql']['conf_dir']                    = '/usr/local/etc'
  default['pdb_mysql']['confd_dir']                   = '/usr/local/etc/mysql/conf.d'
  default['pdb_mysql']['socket']                      = "/tmp/mysqld.sock"
  default['pdb_mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  default['pdb_mysql']['old_passwords']               = 0
  default['pdb_mysql']['grants_path']                 = "/var/db/mysql/grants.sql"
when "windows"
  default['pdb_mysql']['server']['packages']      = ["MySQL Server 5.5"]
  default['pdb_mysql']['version']                 = '5.5.21'
  default['pdb_mysql']['arch']                    = 'win32'
  default['pdb_mysql']['package_file']            = "mysql-#{mysql['version']}-#{mysql['arch']}.msi"
  default['pdb_mysql']['url']                     = "http://www.mysql.com/get/Downloads/MySQL-5.5/#{mysql['package_file']}/from/http://mysql.mirrors.pair.com/"

  default['pdb_mysql']['service_name']            = "mysql"
  default['pdb_mysql']['basedir']                 = "#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\MySQL\\#{mysql['server']['packages'].first}"
  default['pdb_mysql']['data_dir']                = "#{node['mysql']['basedir']}\\Data"
  default['pdb_mysql']['bin_dir']                 = "#{node['mysql']['basedir']}\\bin"
  default['pdb_mysql']['mysqladmin_bin']          = "#{node['mysql']['bin_dir']}\\mysqladmin"
  default['pdb_mysql']['mysql_bin']               = "#{node['mysql']['bin_dir']}\\mysql"

  default['pdb_mysql']['conf_dir']                = node['mysql']['basedir']
  default['pdb_mysql']['old_passwords']           = 0
  default['pdb_mysql']['grants_path']             = "#{node['mysql']['conf_dir']}\\grants.sql"
when "mac_os_x"
  default['pdb_mysql']['server']['packages']      = %w{mysql}
  default['pdb_mysql']['basedir']                 = "/usr/local/Cellar"
  default['pdb_mysql']['data_dir']                = "/usr/local/var/mysql"
  default['pdb_mysql']['root_group']              = "admin"
  default['pdb_mysql']['mysqladmin_bin']          = "/usr/local/bin/mysqladmin"
  default['pdb_mysql']['mysql_bin']               = "/usr/local/bin/mysql"
else
  default['pdb_mysql']['server']['packages']      = %w{mysql-server}
  default['pdb_mysql']['service_name']            = "mysql"
  default['pdb_mysql']['basedir']                 = "/usr"
  default['pdb_mysql']['data_dir']                = "/var/lib/mysql"
  default['pdb_mysql']['root_group']              = "root"
  default['pdb_mysql']['mysqladmin_bin']          = "/usr/bin/mysqladmin"
  default['pdb_mysql']['mysql_bin']               = "/usr/bin/mysql"

  default['pdb_mysql']['conf_dir']                    = '/etc/mysql'
  default['pdb_mysql']['confd_dir']                   = '/etc/mysql/conf.d'
  default['pdb_mysql']['socket']                      = "/var/run/mysqld/mysqld.sock"
  default['pdb_mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  default['pdb_mysql']['old_passwords']               = 0
  default['pdb_mysql']['grants_path']                 = "/etc/mysql/grants.sql"
end

if attribute?('ec2')
  default['pdb_mysql']['ec2_path']    = "/mnt/mysql"
  default['pdb_mysql']['ebs_vol_dev'] = "/dev/sdi"
  default['pdb_mysql']['ebs_vol_size'] = 50
end

default['pdb_mysql']['reload_action'] = "restart" # or "reload" or "none"

default['pdb_mysql']['use_upstart'] = node['platform'] == "ubuntu" && node['platform_version'].to_f >= 10.04

default['pdb_mysql']['auto-increment-increment']        = 1
default['pdb_mysql']['auto-increment-offset']           = 1

default['pdb_mysql']['allow_remote_root']               = false
default['pdb_mysql']['tunable']['character-set-server'] = "utf8"
default['pdb_mysql']['tunable']['collation-server']     = "utf8_general_ci"
default['pdb_mysql']['tunable']['back_log']             = "128"
default['pdb_mysql']['tunable']['key_buffer']           = "64M"
default['pdb_mysql']['tunable']['key_buffer_size']           = "1700M"
default['pdb_mysql']['tunable']['myisam_sort_buffer_size']   = "8M"
default['pdb_mysql']['tunable']['myisam_max_sort_file_size'] = "2147483648"
default['pdb_mysql']['tunable']['myisam_repair_threads']     = "1"
default['pdb_mysql']['tunable']['myisam_recover']            = "BACKUP"
default['pdb_mysql']['tunable']['max_allowed_packet']   = "500M"
default['pdb_mysql']['tunable']['dump_max_allowed_packet']   = "16M"
default['pdb_mysql']['tunable']['max_connections']      = "100"
default['pdb_mysql']['tunable']['max_connect_errors']   = "10"
default['pdb_mysql']['tunable']['concurrent_insert']    = "2"
default['pdb_mysql']['tunable']['connect_timeout']      = "10"
default['pdb_mysql']['tunable']['tmp_table_size']       = "32M"
default['pdb_mysql']['tunable']['max_heap_table_size']  = node['mysql']['tunable']['tmp_table_size']
default['pdb_mysql']['tunable']['bulk_insert_buffer_size'] = node['mysql']['tunable']['tmp_table_size']
default['pdb_mysql']['tunable']['myisam_recover']       = "BACKUP"
default['pdb_mysql']['tunable']['net_read_timeout']     = "30"
default['pdb_mysql']['tunable']['net_write_timeout']    = "30"
default['pdb_mysql']['tunable']['table_cache']          = "64"
default['pdb_mysql']['tunable']['general_log_file']     = "/mnt/log/mysql/mysql.log"
default['pdb_mysql']['tunable']['general_log']          = "1"

default['pdb_mysql']['tunable']['thread_cache']         = "128"
default['pdb_mysql']['tunable']['thread_cache_size']    = 8
default['pdb_mysql']['tunable']['thread_concurrency']   = 10
default['pdb_mysql']['tunable']['thread_stack']         = "192K"
default['pdb_mysql']['tunable']['sort_buffer_size']     = "2M"
default['pdb_mysql']['tunable']['read_buffer_size']     = "128k"
default['pdb_mysql']['tunable']['read_rnd_buffer_size'] = "256k"
default['pdb_mysql']['tunable']['join_buffer_size']     = "128k"
default['pdb_mysql']['tunable']['wait_timeout']         = "180"
default['pdb_mysql']['tunable']['open-files-limit']     = "8192"
default['pdb_mysql']['tunable']['open-files']           = "1024"

default['pdb_mysql']['tunable']['sql_mode'] = nil

default['pdb_mysql']['tunable']['skip-character-set-client-handshake'] = false
default['pdb_mysql']['tunable']['skip-name-resolve']                   = false


default['pdb_mysql']['tunable']['server_id']                       = "1"
default['pdb_mysql']['tunable']['log_bin']                         = nil
default['pdb_mysql']['tunable']['log_bin_trust_function_creators'] = false

default['pdb_mysql']['tunable']['relay_log']                       = nil
default['pdb_mysql']['tunable']['relay_log_index']                 = nil
default['pdb_mysql']['tunable']['log_slave_updates']               = false

default['pdb_mysql']['tunable']['sync_binlog']                     = 0
default['pdb_mysql']['tunable']['skip_slave_start']                = false
default['pdb_mysql']['tunable']['read_only']                       = false

default['pdb_mysql']['tunable']['log_error']                       = "/mnt/log/mysql/error.log"
default['pdb_mysql']['tunable']['log_warnings']                    = false
default['pdb_mysql']['tunable']['log_queries_not_using_index']     = true
default['pdb_mysql']['tunable']['log_bin_trust_function_creators'] = false

default['pdb_mysql']['tunable']['innodb_log_file_size']            = "5M"
default['pdb_mysql']['tunable']['innodb_buffer_pool_size']         = "2048M"
default['pdb_mysql']['tunable']['innodb_buffer_pool_instances']    = "4"
default['pdb_mysql']['tunable']['innodb_additional_mem_pool_size'] = "20M"
default['pdb_mysql']['tunable']['innodb_data_file_path']           = "ibdata1:10M:autoextend"
default['pdb_mysql']['tunable']['innodb_flush_method']             = false
default['pdb_mysql']['tunable']['innodb_log_buffer_size']          = "8M"
default['pdb_mysql']['tunable']['innodb_write_io_threads']         = "4"
default['pdb_mysql']['tunable']['innodb_io_capacity']              = "200"
default['pdb_mysql']['tunable']['innodb_file_per_table']           = true
default['pdb_mysql']['tunable']['innodb_lock_wait_timeout']        = "20"
if node['cpu'].nil? or node['cpu']['total'].nil?
  default['pdb_mysql']['tunable']['innodb_thread_concurrency']       = "8"
  default['pdb_mysql']['tunable']['innodb_commit_concurrency']       = "8"
  default['pdb_mysql']['tunable']['innodb_read_io_threads']          = "8"
else
  default['pdb_mysql']['tunable']['innodb_thread_concurrency']       = "#{(Integer(node['cpu']['total'])) * 2}"
  default['pdb_mysql']['tunable']['innodb_commit_concurrency']       = "#{(Integer(node['cpu']['total'])) * 2}"
  default['pdb_mysql']['tunable']['innodb_read_io_threads']          = "#{(Integer(node['cpu']['total'])) * 2}"
end
default['pdb_mysql']['tunable']['innodb_flush_log_at_trx_commit']  = "2"
default['pdb_mysql']['tunable']['default-character-set']           =  "utf8"
default['pdb_mysql']['tunable']['innodb_support_xa']               = true
default['pdb_mysql']['tunable']['innodb_table_locks']              = true
default['pdb_mysql']['tunable']['skip-innodb-doublewrite']         = false

default['pdb_mysql']['tunable']['transaction-isolation'] = nil

default['pdb_mysql']['tunable']['query_cache_limit']    = "1M"
default['pdb_mysql']['tunable']['query_cache_size']     = "64M"

default['pdb_mysql']['tunable']['log_slow_queries']     = "/var/log/mysql/slow.log"
default['pdb_mysql']['tunable']['slow_query_log']       = node['mysql']['tunable']['log_slow_queries'] # log_slow_queries is deprecated
                                                                                                   # in favor of slow_query_log
default['pdb_mysql']['tunable']['long_query_time']      = 2

default['pdb_mysql']['tunable']['expire_logs_days']     = 10
default['pdb_mysql']['tunable']['max_binlog_size']      = "100M"
default['pdb_mysql']['tunable']['binlog_cache_size']    = "32K"

default['pdb_mysql']['tmpdir'] = ["/tmp"]
default['pdb_mysql']['language']  = "/usr/share/mysql/english"
default['pdb_mysql']['default-storage-engine'] = "InnoDB"
default['pdb_mysql']['read_only'] = false

default['pdb_mysql']['log_dir'] = node['mysql']['data_dir']
default['pdb_mysql']['log_files_in_group'] = false
default['pdb_mysql']['innodb_status_file'] = false

unless node['platform_family'] && node['platform_version'].to_i < 6
  # older RHEL platforms don't support these options
  default['pdb_mysql']['tunable']['event_scheduler']  = 0
  default['pdb_mysql']['tunable']['table_open_cache'] = "128"
  default['pdb_mysql']['tunable']['binlog_format']    = "statement" if node['mysql']['tunable']['log_bin']
end
