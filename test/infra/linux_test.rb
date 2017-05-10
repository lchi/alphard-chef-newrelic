# # encoding: utf-8

# Inspec test for recipe alphard-chef-newrelic::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?

  describe package('newrelic-infra') do
    it { should be_installed }
  end

  describe service('newrelic-infra') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end

end
