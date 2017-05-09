name 'build_cookbook'
maintainer 'Hydra Technologies, Inc'
maintainer_email 'chef@hydra-technologies.net'
license 'apachev2'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'delivery-truck'
