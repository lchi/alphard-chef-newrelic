#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-newrelic
# Recipe:: linux
#
# Copyright:: 2017, Hydra Technologies, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

deb_version_to_codename = { 10 => 'buster',
                            9 => 'stretch',
                            8 => 'jessie',
                            7 => 'wheezy',
                            16 => 'xenial',
                            14 => 'trusty',
                            12 => 'precise' }

case node['platform_family']
when 'debian'
  # Creates APT repo file

  include_recipe 'apt'

  apt_repository 'newrelic-infra' do
    uri 'http://download.newrelic.com/infrastructure_agent/linux/apt'
    key 'http://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg'
    distribution deb_version_to_codename[node['platform_version'].to_i]
    components ['main']
    arch 'amd64'
    notifies :run, 'execute[apt-get update]', :immediately
  end

when 'rhel'
  # Adds Yum repo

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

  # Updates Yum repo

  execute 'Update Infra Yum repo' do
    command "yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'"
  end
end

# Install the newrelic-infra agent

package 'newrelic-infra' do
  action node['alphard']['newrelic']['infra']['action']
  version node['alphard']['newrelic']['infra']['version'] unless node['alphard']['newrelic']['infra']['version'].nil?
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
  variables node['alphard']['newrelic']['infra']['configuration'].merge(
    license_key: node['alphard']['newrelic']['license']
  )
  notifies :restart, 'service[newrelic-infra]', :delayed
end
