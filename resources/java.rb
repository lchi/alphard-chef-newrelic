#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-newrelic
# Resource:: java
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
resource_name :newrelic_java_agent

actions :nothing, :install
default_action :install

property :user, kind_of: String
property :group, kind_of: String
property :version, kind_of: String
property :install_directory, kind_of: String
property :cookbook, kind_of: String
property :template_source, kind_of: String
property :configuration, kind_of: String

action :install do
  newrelic = node['alphard']['newrelic']
  java = newrelic['java']

  license = newrelic['license']
  user = new_resource.user || newrelic['user']
  group = new_resource.group || newrelic['group']
  version = new_resource.version || java['version'] || 'latest'
  version = 'current' if version == 'latest'
  directory = new_resource.install_directory || java['directory']
  cookbook = new_resource.cookbook || 'alphard-chef-newrelic'
  template = new_resource.template_source || java['template']
  configuration = new_resource.configuration || java['configuration']

  # Creates jar directory

  directory directory do
    owner user
    group group
    recursive true
    mode '0775'
    action :create
  end

  # Downloads and installs jar file

  apt_update 'update' # TODO: Generalize this for all platforms
  apt_package 'zip'   # TODO: Generalize this for all platforms

  archive_name = 'newrelic-java.zip'
  archive_name = "newrelic-java-#{version}.zip" unless version == 'current'
  archive_file = "#{directory}/#{archive_name}"
  archive_url = "https://download.newrelic.com/newrelic/java-agent/newrelic-agent/#{version}/#{archive_name}"

  remote_file archive_file.to_s do
    source archive_url
    user user
    group group
    mode '0664'
    action :create
    notifies :run, 'execute[unzip_jar]', :immediately
  end

  execute 'unzip_jar' do
    user user
    group group
    command "unzip -oj #{archive_file} -d #{directory}"
    action :nothing
  end

  # Creates configuration file

  template "#{directory}/newrelic.yml" do
    cookbook cookbook
    source template
    owner user
    group group
    mode '0644'
    variables configuration.merge(
      license_key: license
    )
    sensitive true
    action :create
  end
end
