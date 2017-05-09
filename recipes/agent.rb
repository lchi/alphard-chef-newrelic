# Ensure license key is provided
if node['alphard']['newrelic']['infrastructure']['license_key'].nil? || node['alphard']['newrelic']['infrastructure']['license_key'].empty?
  raise 'No New Relic license key provided'
end

# Ensure platform & version is supported
case node['platform_family']
when 'debian'
  # TODO: Add better debian platform/version detection
  include_recipe 'alphard-chef-newrelic-infrastructure::agent_linux'
when 'rhel'
  case node['platform']
  when 'centos'
    case node['platform_version']
    when /^6/, /^7/
      include_recipe 'alphard-chef-newrelic-infrastructure::agent_linux'
    else
      raise 'The New Relic Infrastructure agent is not currently supported on this platform version'
    end
  when 'amazon'
    include_recipe 'alphard-chef-newrelic-infrastructure::agent_linux'
  else
    raise 'The New Relic Infrastructure agent is not currently supported on this platform'
  end
when 'windows'
  include_recipe 'alphard-chef-newrelic-infrastructure::agent_windows'
else
  raise 'The New Relic Infrastructure agent is not currently supported on this platform'
end
