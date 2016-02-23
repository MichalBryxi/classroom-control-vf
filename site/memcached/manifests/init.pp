class memcached {
  package { 'memcached':
    ensure => present,
  }
  
  file { '/etc/sysconfig/memcached':
    source => 'puppet:///modules/memcached/memcached.conf',
    ensure => present,
  }
  
  service { 'memcached':
    ensure    => running,
    subscribe => File['/etc/sysconfig/memcached'],
    require   => Package['memcached'],
  }
}
