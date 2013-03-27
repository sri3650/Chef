default[:monit][:notify_email]          = "monitor@chronus.com"

default[:monit][:poll_period]           = 60
default[:monit][:poll_start_delay]      = 120

default[:monit][:mail_format][:subject] = "$HOST: $SERVICE $EVENT at $DATE"
default[:monit][:mail_format][:from]    = "monitor@chronus.com"
default[:monit][:mail_format][:message]    = <<-EOS
Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.
Yours sincerely,
monit
EOS

