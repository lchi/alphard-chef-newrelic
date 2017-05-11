default['alphard']['newrelic']['license'] = nil

# Infra
default['alphard']['newrelic']['infra']['action'] = 'install'
default['alphard']['newrelic']['infra']['version'] = nil
default['alphard']['newrelic']['infra']['configuration'] =
  { license_key: node['alphard']['newrelic']['license'],
    log_path: '/var/log',
    log_file: '/var/log/newrelic.log',
    verbose: 'false' }

# Java
default['alphard']['newrelic']['java']['action'] = 'install'
default['alphard']['newrelic']['java']['version'] = 'latest'
default['alphard']['newrelic']['java']['directory'] = '/opt/newrelic/java_agent'
default['alphard']['newrelic']['java']['template'] = 'newrelic-java.yml.erb'
default['alphard']['newrelic']['java']['configuration'] =
  { license_key: node['alphard']['newrelic']['license'],
    log_path: node['alphard']['newrelic']['java']['directory'],
    log_file: "#{node['alphard']['newrelic']['java']['directory']}/newrelic.log",
    verbose: 'false' }
