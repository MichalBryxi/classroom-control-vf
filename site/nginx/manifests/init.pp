class nginx {
  $package = 'nginx'
  case $operatingsystem {
    'CentOS', 'RedHat': {
      $document_root = '/var/www'    
      $service_user = 'nginx'
      $log_dir = '/var/log/nginx'
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

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  
  package { $package:
    ensure => present,
  }
  
  file { '/var/www':
    ensure => directory,
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => present,
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure => present,
    content => template('nginx/default.conf.erb'),
  }
  
  file { '/var/www/index.html':
    ensure => present,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  service { 'nginx':
    ensure    => running,
    subscribe => File['/etc/nginx/nginx.conf', '/etc/nginx/conf.d/default.conf'],
    require   => Package['nginx'],
  }
}
