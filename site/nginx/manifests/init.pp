class nginx (
  $root = '/var/www'
) inherits nginx::params {
  $document_root = $root

  File {
    owner => $file_owner,
    group => $file_group,
    mode  => '0644',
  }
  
  package { $package:
    ensure => present,
  }
  
  file { $document_root:
    ensure => directory,
  }
  
  file { "${config_dir}/nginx.conf":
    ensure => present,
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { "${server_block_dir}/default.conf":
    ensure => present,
    content => template('nginx/default.conf.erb'),
  }
  
  file { "${document_root}/index.html":
    ensure => present,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  service { $service_name:
    ensure    => running,
    subscribe => File["${config_dir}/nginx.conf", "${server_block_dir}/default.conf"],
    require   => Package[$package],
  }
}
