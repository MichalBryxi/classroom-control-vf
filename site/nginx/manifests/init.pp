class nginx {
  $package = 'nginx'
  case $operatingsystem {
    'RedHat': {
      $document_root = '/var/www'    
    }
    'Debian': {
      $document_root = '/var/www'
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
