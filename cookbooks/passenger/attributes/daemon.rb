default[:passenger][:path] = '/opt/nginx'
default[:passenger][:configure_flags] = '--with-http_ssl_module'
default[:passenger][:log_path] = '/var/log/passenger/'
default[:passenger][:default_user] = 'app'
default[:passenger][:nginx_log_path] = '/mnt/log/nginx'
default[:passenger][:tuned_ruby_path] = '/usr/local/bin/ruby_tuned'

# Tune these for your environment, see:
# http://www.modrails.com/documentation/Users%20guide%20Nginx.html#_resource_control_and_optimization_options
default[:passenger][:max_pool_size] = 6
default[:passenger][:min_instances] = 1
default[:passenger][:pool_idle_time] = 0
default[:passenger][:max_instances_per_app] = 0
# a list of URL's to pre-start.
default[:passenger][:pre_start] = []

default[:passenger][:sendfile] = true
default[:passenger][:tcp_nopush] = true
default[:passenger][:tcp_nodelay] = true
# Nginx's default is 0, but we don't want that.
default[:passenger][:keepalive_timeout] = 65
default[:passenger][:gzip] = false
default[:passenger][:gzip_http_version] = "1.1"
default[:passenger][:gzip_vary] = true
default[:passenger][:gzip_comp_level] = "6"
default[:passenger][:gzip_proxied] = "any"
default[:passenger][:gzip_types] = [	
  "application/json",
  "application/x-javascript",
  "application/xhtml+xml",
  "application/xml",
  "application/xml+rss",
  "text/css",
  "text/javascript",
  "text/plain",
  "text/html"
]
default[:passenger][:gzip_buffers] = "16 8k"
default[:passenger][:gzip_disable] = "msie6"
default[:passenger][:worker_connections] = 1024
default[:passenger][:public_path] = "/mnt/app/current/public"
default[:passenger][:ssl_path] = "/etc/ec2onrails/ssl"

# Enable the status server on 127.0.0.1
default[:passenger][:status_server] = true

default[:passenger][:ruby_heap_min_slots] = 1800000
default[:passenger][:ruby_heap_free_min] = 125000
default[:passenger][:ruby_heap_slots_increment] = 150000
default[:passenger][:ruby_heap_slots_growth_factor] = 1
default[:passenger][:ruby_gc_malloc_limit] = 80000000