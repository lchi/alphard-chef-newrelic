name                  'alphard-chef-newrelic-infrastructure'
version               '0.2.0'
license               'Apache-2.0'
maintainer            'Hydra Technologies, Inc'
maintainer_email      'chef@hydra-technologies.net'
description           'Installs/Configures alphard-chef-newrelic-infrastructure'
long_description      IO.read(File.join(File.dirname(__FILE__), 'README.md'))

recipe                'alphard-chef-newrelic-infrastructure::default', 'Installs/Configures New Relic infrastructure agent'

%w(ubuntu debian centos fedora).each do |os|
  supports os
end

source_url            'https://github.com/hydra-technologies/alphard-chef-newrelic-infrastructure' if respond_to?(:source_url)
issues_url            'https://github.com/hydra-technologies/alphard-chef-newrelic-infrastructure/issues' if respond_to?(:issues_url)

chef_version          '>=12.5' if respond_to?(:chef_version)
