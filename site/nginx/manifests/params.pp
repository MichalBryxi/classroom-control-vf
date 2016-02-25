class nginx::params (

){
  case $operatingsystem {
    'CentOS', 'RedHat': {
      $service_user = 'nginx'
      $log_dir = '/var/log/nginx'
      $package = 'nginx'
      $file_owner = 'root'
      $file_group = 'root'
      $config_dir = '/etc/nginx'
      $server_block_dir = '/etc/nginx/conf.d'
      $service_name = 'nginx'
    }
    'Debian': {
      $document_root = '/var/www'
      # ...
    }
    'Windows': {
      $document_root = 'C:/ProgramData/nginx/html'
      # ...
    }
  }
}
