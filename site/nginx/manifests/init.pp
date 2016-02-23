class nginx {
  package { 'nginx':
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
    source => 'puppet:///modules/nginx/default.conf',
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
