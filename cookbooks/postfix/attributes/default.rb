#
# Author:: Joshua Timberman <joshua@opscode.com>
# Copyright:: Copyright (c) 2009, Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

default['postfix']['mail_type']  = "master"
default['postfix']['myhostname'] = "www.chronus.com"
default['postfix']['mydomain']   = "chronus.com"
default['postfix']['myorigin']   = "$mydomain"
default['postfix']['mail_relay_networks']        = "127.0.0.0/8"
default['postfix']['relayhost_role']             = "relayhost"
default['postfix']['multi_environment_relay'] = false

default['postfix']['smtpd_use_tls'] = "no"
default['postfix']['smtp_sasl_auth_enable'] = "yes"
default['postfix']['smtp_sasl_security_options'] = "noanonymous"
default['postfix']['smtp_tls_cafile'] = "/etc/postfix/cacert.pem"
default['postfix']['smtp_use_tls']    = "yes"

default['postfix']['smtp_relayhost_authsmtp'] = "[mail.authsmtp.com]:2525"
default['postfix']['smtp_connection_cache_destinations']  = "mail.authsmtp.com"
default['postfix']['header_size_limit']  = 4096000

#Setting mail attchment size to 25MB
default['postfix']['mail_attachment_size_limit'] = 26214400

default['postfix']['soft_bounce'] = "yes"
default['postfix']['smtp_sasl_authsmtp_user_name'] = "ac35265"
default['postfix']['smtp_sasl_authsmtp_passwd']    = "znqw4tdqj"

default['postfix']['smtp_relayhost_mailgun'] = "[smtp.mailgun.org]:587"

default['postfix']['default_destination_concurrency_limit']    = "4"

default['postfix']['aliases'] = {}
