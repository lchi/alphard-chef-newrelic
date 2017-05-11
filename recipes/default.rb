#
# Author:: Frederic Nowak (<frederic.nowak@hydra-technologies.net>)
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

# Ensures a license has benn provided

if node['alphard']['newrelic']['license'].nil? || node['alphard']['newrelic']['license'].empty?
  raise 'no New Relic license key provided!'
end

# Ensures platform & version is supported

newrelic_linux_recipe = 'alphard-chef-newrelic::linux'
newrelic_error_message =
  'The New Relic infrastructure agent is not currently supported on this platform: ' \
  "#{node['platform']} #{node['platform_version']}!"

case node['platform_family']
when 'debian'
  # TODO: Add better debian platform/version detection
  include_recipe newrelic_linux_recipe
when 'rhel'
  case node['platform']
  when 'centos'
    case node['platform_version']
    when /^6/, /^7/
      include_recipe newrelic_linux_recipe
    else
      raise newrelic_error_message
    end
  when 'amazon'
    include_recipe newrelic_linux_recipe
  else
    raise newrelic_error_message
  end
when 'windows'
  raise newrelic_error_message
else
  raise newrelic_error_message
end
