# Disable filebucket by default for all File resources:
File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}

node default {
  exec { 'cowmotd':
    command => "cowsay 'Welcome to ${::fqdn}!' > /etc/motd",
    creates => '/etc/motd',
    path    => '/usr/local/bin',
  }
  
  file { '/etc/motd':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  
  package { 'cowsay':
    ensure => present,
    provider => gem,
  }
  
  host { 'testing.puppetlabs.vm':
    ip => '127.0.0.1',
  }
}
