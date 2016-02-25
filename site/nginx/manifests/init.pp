class nginx (
  $service_user     = $::nginx::params::service_user,
  $log_dir          = $::nginx::params::log_dir,
  $package          = $::nginx::params::package,
  $file_owner       = $::nginx::params::file_owner,
  $file_group       = $::nginx::params::file_group,
  $config_dir       = $::nginx::params::config_dir,
  $server_block_dir = $::nginx::params::server_block_dir,
  $service_name     = $::nginx::params::service_name,
  $root             = $::nginx::params::root,
  $on               = 'stopped',
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
    ensure    => $on,
    subscribe => File["${config_dir}/nginx.conf", "${server_block_dir}/default.conf"],
    require   => Package[$package],
  }
}
