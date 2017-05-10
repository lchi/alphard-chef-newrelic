# Ensure license key is provided
if node['alphard']['newrelic']['infra']['license_key'].nil? || node['alphard']['newrelic']['infra']['license_key'].empty?
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
