# default to installing the latest version, but don't auto upgrade moving forward
# change action to 'upgrade' to automatically fetch the latest version of the agent
# change version to a particular version to pin the agent to a particular version
default['alphard']['newrelic']['infrastructure']['agent_action'] = 'install'
default['alphard']['newrelic']['infrastructure']['agent_version'] = nil

default['alphard']['newrelic']['infrastructure']['license_key'] = nil
default['alphard']['newrelic']['infrastructure']['display_name'] = nil
default['alphard']['newrelic']['infrastructure']['proxy'] = nil
default['alphard']['newrelic']['infrastructure']['verbose'] = nil
default['alphard']['newrelic']['infrastructure']['log_file'] = nil
