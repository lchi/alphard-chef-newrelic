default['alphard']['newrelic']['license'] = nil

# Infrastructure
# default to installing the latest version, but don't auto upgrade moving forward
# change action to 'upgrade' to automatically fetch the latest version of the agent
# change version to a particular version to pin the agent to a particular version
default['alphard']['newrelic']['infra']['agent_action'] = 'install'
default['alphard']['newrelic']['infra']['agent_version'] = nil

default['alphard']['newrelic']['infra']['license_key'] = node['alphard']['newrelic']['license']
default['alphard']['newrelic']['infra']['display_name'] = nil
default['alphard']['newrelic']['infra']['proxy'] = nil
default['alphard']['newrelic']['infra']['verbose'] = nil
default['alphard']['newrelic']['infra']['log_file'] = nil

# Java
default['alphard']['newrelic']['java']['license'] = node['alphard']['newrelic']['license']
# default['alphard']['newrelic']['java']['jar_path'] = nil
# default['alphard']['newrelic']['java']['log_path'] = nil
# default['alphard']['newrelic']['java']['log_file'] = nil
