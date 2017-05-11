# # encoding: utf-8

# Inspec test for recipe alphard-chef-newrelic::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

directory = '/opt/newrelic/java_agent'

describe file(directory) do
  it { should be_directory }
end

describe file("#{directory}/newrelic.jar") do
  it { should be_file }
end

describe file("#{directory}/newrelic.yml") do
  it { should be_file }
end
