#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-newrelic
# Recipe:: default
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

# Ensure license key is provided
if node['alphard']['newrelic']['infra']['license'].nil? || node['alphard']['newrelic']['infra']['license'].empty?
  raise 'No New Relic license key provided'
end

# Ensure platform & version is supported
case node['platform_family']
when 'debian'
  # TODO: Add better debian platform/version detection
  include_recipe 'alphard-chef-newrelic::linux'
when 'rhel'
  case node['platform']
  when 'centos'
    case node['platform_version']
    when /^6/, /^7/
      include_recipe 'alphard-chef-newrelic::linux'
    else
      raise 'The New Relic Infrastructure agent is not currently supported on this platform version'
    end
  when 'amazon'
    include_recipe 'alphard-chef-newrelic::linux'
  else
    raise 'The New Relic Infrastructure agent is not currently supported on this platform'
  end
when 'windows'
  raise 'The New Relic Infrastructure agent is not currently supported on windows'
else
  raise 'The New Relic Infrastructure agent is not currently supported on this platform'
end
