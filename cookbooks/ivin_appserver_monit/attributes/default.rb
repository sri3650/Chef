include_attribute "ivin_common_dirs"

default[:ivin_appserver_monit][:processes]    = %w[delayed_job redis searchd localeapp]