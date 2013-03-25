default[:passenger][:production][:path] = '/opt/nginx'
default[:passenger][:production][:configure_flags] = '--with-http_stub_status_module --with-http_ssl_module'
default[:passenger][:production][:log_path] = '/var/log/passenger/'
default[:passenger][:production][:default_user] = 'app'
default[:passenger][:production][:nginx_log_path] = '/mnt/log/nginx'
default[:passenger][:production][:tuned_ruby_path] = '/usr/local/bin/ruby_tuned'

# Tune these for your environment, see:
# http://www.modrails.com/documentation/Users%20guide%20Nginx.html#_resource_control_and_optimization_options
default[:passenger][:production][:max_pool_size] = 6
default[:passenger][:production][:min_instances] = 1
default[:passenger][:production][:pool_idle_time] = 0
default[:passenger][:production][:max_instances_per_app] = 0
# a list of URL's to pre-start.
default[:passenger][:production][:pre_start] = []

default[:passenger][:production][:sendfile] = true
default[:passenger][:production][:tcp_nopush] = true
default[:passenger][:production][:tcp_nodelay] = true
# Nginx's default is 0, but we don't want that.
default[:passenger][:production][:keepalive_timeout] = 65
default[:passenger][:production][:gzip] = true
default[:passenger][:production][:gzip_http_version] = "1.1"
default[:passenger][:production][:gzip_vary] = true
default[:passenger][:production][:gzip_comp_level] = "6"
default[:passenger][:production][:gzip_proxied] = "any"
default[:passenger][:production][:gzip_types] = [	
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
default[:passenger][:production][:gzip_buffers] = "16 8k"
default[:passenger][:production][:gzip_disable] = "msie6"
default[:passenger][:production][:worker_connections] = 1024
default[:passenger][:production][:public_path] = "/mnt/app/current/public"
default[:passenger][:production][:ssl_path] = "/etc/ec2onrails/ssl"

# Enable the status server on 127.0.0.1
default[:passenger][:production][:status_server] = true

default[:passenger][:production][:ruby_heap_min_slots] = 1800000
default[:passenger][:production][:ruby_heap_free_min] = 125000
default[:passenger][:production][:ruby_heap_slots_increment] = 150000
default[:passenger][:production][:ruby_heap_slots_growth_factor] = 1
default[:passenger][:production][:ruby_gc_malloc_limit] = 80000000