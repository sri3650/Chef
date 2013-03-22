include_attribute "ivin_common_dirs"

default[:ivin_application][:ssl_certificate_path] = "/mnt/ssl"
default[:ivin_application][:nginx_log_path] = "/mnt/log/nginx"