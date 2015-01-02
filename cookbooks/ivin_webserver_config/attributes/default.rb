include_attribute "ivin_webserver_dirs"
include_attribute "passenger::daemon"
default["nginx"]["http"] = 8080
default["nginx"]["https"] = 8181