default[:redis][:version]       = '2.2.2'
default[:redis][:url]           = "http://redis.googlecode.com/files/redis-#{redis[:version]}.tar.gz"
default[:redis][:port]          = 6379
default[:redis][:log_path]      = '/mnt/log'
