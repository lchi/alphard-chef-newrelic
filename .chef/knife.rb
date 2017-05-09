current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                'hydra-technologies-travis'
client_key               "#{current_dir}/hydra-technologies-travis.pem"
chef_server_url          'https://api.chef.io/organizations/hydra-technologies'
