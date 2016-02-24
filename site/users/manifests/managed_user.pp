derfine user::managed_user(
  $user    = $title,
  $group   = $title,
) {
  user { $user:
    managehome => false,
    ensure     => present,
  }
  
  file { "/home/${user}":
    ensure  => directory,
    require => User[$user],
  }
}
