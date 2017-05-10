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

property :user, name_attribute: true, kind_of: String
property :group, name_attribute: true, kind_of: String
property :jar_dir, name_attribute: true, kind_of: String

action :install do
  newrelic = node['alphard']['newrelic']
  java = newrelic['java']

  user = newrelic['user']
  group = newrelic['group']
  version = java['version']
  version = 'current' if version == 'latest'
  jar_dir = java['jar_dir']
  jar_file = 'newrelic-java.zip'
  jar_file = "newrelic-java-#{version}.zip" unless version == 'latest'

  # Creates jar directory

  directory jar_dir do
    owner user
    group group
    recursive true
    mode '0775'
    action :create
  end

  # Downloads and installs jar file

  package 'unzip'

  jar_url = "https://download.newrelic.com/newrelic/java-agent/newrelic-agent/#{version}/#{jar_file}"

  remote_file "#{jar_dir}/#{jar_file}" do
    source jar_url
    user user
    group group
    mode '0664'
    action :create
    notifies :run, 'execute[unzip_jar]', :immediately
  end

  execute 'unzip_jar' do
    cwd jar_dir
    user user
    group group
    command "unzip -oj #{jar_file} newrelic/newrelic.jar"
    action :nothing
  end

  # Creates configuration file

  template "#{new_resource.install_dir}/newrelic.yml" do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    owner new_resource.app_user
    group new_resource.app_group
    mode '0644'
    variables(
      resource: new_resource
    )
    sensitive true
    action :create
  end

  # Grants write permissions to log files

  path = new_resource.logfile_path
  until path.nil? || path.empty? || path == ::File::SEPARATOR
    directory path do
      group group
      mode '0775'
      action :create
    end
    path = ::File.dirname(path)
  end
end
