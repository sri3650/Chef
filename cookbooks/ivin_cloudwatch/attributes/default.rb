default[:packages_for_cloudwatch] = %w(
  libwww-perl
  libcrypt-ssleay-perl
)

default[:ivin_application][:cloudwatch_log_path] = "/mnt/log/cloudwatch"
default[:ivin_application][:cloudwatch_app_path] = "/opt/cloudwatch"
