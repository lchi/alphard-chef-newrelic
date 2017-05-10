# Installs and configures the New Relic Infrastructure agent on Linux

deb_version_to_codename = { 10 => 'buster',
                            9 => 'stretch',
                            8 => 'jessie',
                            7 => 'wheezy',
                            16 => 'xenial',
                            14 => 'trusty',
                            12 => 'precise' }

case node['platform_family']
when 'debian'
  # Add public GPG key
  gpg_key_file = "#{Chef::Config[:file_cache_path]}/newrelic-infra.gpg"
  remote_file gpg_key_file do
    source 'https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg'
  end
  execute 'add apt key' do
    command "apt-key add #{gpg_key_file}"
  end

  # Create APT repo file
  apt_repository 'newrelic-infra' do
    uri 'https://download.newrelic.com/infrastructure_agent/linux/apt'
    distribution deb_version_to_codename[node['platform_version'].to_i]
    components ['main']
    arch 'amd64'
  end

  # Update APT repo -- if you don't need this in your regular runs,
  # please customize a private fork
  execute 'apt-get update'

when 'rhel'
  # Add Yum repo
  case node['platform']
  when 'centos'
    rhel_version = node['platform_version'].to_i
  when 'amazon'
    case node['platform_version'].to_i
    when 2013, 2014, 2015, 2016, 2017
      rhel_version = 6
    end
  end

  yum_repository 'newrelic-infra' do
    description 'New Relic Infrastructure'
    baseurl "https://download.newrelic.com/infrastructure_agent/linux/yum/el/#{rhel_version}/x86_64"
    gpgkey 'https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg'
    gpgcheck true
    repo_gpgcheck true
  end

  # Update Yum repo
  execute 'Update Infra Yum repo' do
    command "yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'"
  end
end

# Install the newrelic-infra agent
package 'newrelic-infra' do
  action node['alphard']['newrelic']['infra']['agent_action']
  version node['alphard']['newrelic']['infra']['agent_version'] unless node['alphard']['newrelic']['infra']['agent_version'].nil?
end

# Setup newrelic-infra service
service 'newrelic-infra' do
  action [:enable, :start]
end

# Lay down newrelic-infra agent config
template '/etc/newrelic-infra.yml' do
  source 'newrelic-infra.yml.erb'
  owner 'root'
  group 'root'
  mode '00644'
  variables(
    'license_key' => node['alphard']['newrelic']['infra']['license_key'],
    'display_name' => node['alphard']['newrelic']['infra']['display_name'],
    'log_file' => node['alphard']['newrelic']['infra']['log_file'],
    'verbose' => node['alphard']['newrelic']['infra']['verbose'],
    'proxy' => node['alphard']['newrelic']['infra']['proxy']
  )
  notifies :restart, 'service[newrelic-infra]', :delayed
end