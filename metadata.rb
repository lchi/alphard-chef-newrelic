name                  'alphard-chef-newrelic'
version               '0.5.1'
license               'Apache-2.0'
maintainer            'Hydra Technologies, Inc'
maintainer_email      'chef@hydra-technologies.net'
description           'Installs/Configures New Relic agents'
long_description      IO.read(File.join(File.dirname(__FILE__), 'README.md'))

recipe                'alphard-chef-newrelic::default', 'Installs/Configures New Relic linux infrastructure agent'
recipe                'alphard-chef-newrelic::java', 'Installs/Configures New Relic java application agent'

%w(ubuntu debian centos fedora).each do |os|
  supports os
end

source_url            'https://github.com/hydra-technologies/alphard-chef-newrelic' if respond_to?(:source_url)
issues_url            'https://github.com/hydra-technologies/alphard-chef-newrelic/issues' if respond_to?(:issues_url)

chef_version          '>=12.5' if respond_to?(:chef_version)
