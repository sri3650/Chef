default[:redis][:version]      = '2.8.6'
default[:redis][:url]          = "http://download.redis.io/releases/redis-#{redis[:version]}.tar.gz"
default[:redis][:listen_port]  = "6379"
default[:redis][:appendonly]   = "no"
default[:redis][:appendfsync]  = "everysec"
