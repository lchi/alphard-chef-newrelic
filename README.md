[![Cookbook Version](https://img.shields.io/cookbook/v/alphard-chef-alphard-chef-newrelic-infrastructurestructure.svg)](https://supermarket.chef.io/cookbooks/alphard-chef-alphard-chef-newrelic-infrastructurestructure)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Build Status](https://travis-ci.org/hydra-technologies/alphard-chef-alphard-chef-newrelic-infrastructurestructure.svg?branch=master)](https://travis-ci.org/hydra-technologies/alphard-chef-alphard-chef-newrelic-infrastructurestructure)
[![Coverage Status](https://coveralls.io/repos/github/hydra-technologies/alphard-chef-alphard-chef-newrelic-infrastructurestructure/badge.svg?branch=master)](https://coveralls.io/github/hydra-technologies/alphard-chef-alphard-chef-newrelic-infrastructurestructure?branch=master)

# Cookbook 'alphard-chef-alphard-chef-newrelic-infrastructurestructure'

This cookbook installs and configures the New Relic Infrastructure agent.

## Requirements

### Platforms

- RHEL
  - CentOS 7
  - CentOS 6
  - Amazon Linux (all versions)
- Ubuntu
  - 16 Xenial
  - 14 Trusty
  - 12 Precise
- Debian
  - 10 Buster
  - 9 Stretch
  - 8 Jessie
  - 7 Wheezy

### Chef

- Chef 12+

### Cookbooks

- none

## Recipes

### default
Include the default recipe to install and configure the New Relic Infrastructure agent.

### agent
The `agent` recipe will validate required attributes and do basic platform detection to decide which platform specific recipe to include.

### agent_linux
The `agent_linux` recipe:

1. Adds the `alphard-chef-newrelic-infrastructure` package repository source
1. Installs|upgrades|removes `alphard-chef-newrelic-infrastructure` package
1. Sets up the `alphard-chef-newrelic-infrastructure` agent service
1. Sets the `alphard-chef-newrelic-infrastructure.yml` config file

### agent_windows
(Available in the future)

## Attributes

See `attributes/defaults.rb` for default values.

- `node['alphard']['newrelic']['infrastructure']['license_key']` - Your New Relic license key.
- `node['alphard']['newrelic']['infrastructure']['log_file']` - Override system log file location by providing Log path and file name.
- `node['alphard']['newrelic']['infrastructure']['verbose']` - Log verbosity setting. Type: String
- `node['alphard']['newrelic']['infrastructure']['proxy']` - Your proxy url if required.
- `node['alphard']['newrelic']['infrastructure']['agent_action']` - `alphard-chef-newrelic-infrastructure` package actions. Values:
  - `'install'`: _(Default)_ Installs package. If `'agent_version'` is specified, installs specific version.
  - `'upgrade'`: Installs package and/or ensures it's the latest version.
  - `'remove'`:  Removes the package.
- `node['alphard']['newrelic']['infrastructure']['agent_version']` - Specify `alphard-chef-newrelic-infrastructure` package version to pin.

## Usage

1. Add the `alphard-chef-newrelic-infrastructure` cookbook dependency to your `metadata.rb` or `Berksfile`
1. Set `node['alphard']['newrelic']['infrastructure']['license_key']` attribute with your New Relic license key
1. Include `default` recipe or add it to your run list

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License

Copyright 2009-2016, Hydra Technologies, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Authors

- Frédéric Nowak - frederic.nowak@hydra-technologies.net

