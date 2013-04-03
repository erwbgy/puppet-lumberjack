class lumberjack (
  $files            = undef,
  $host             = undef,
  $port             = undef,
  $basedir          = '/opt/lumberjack',
  $fields           = undef,
  $down             = false,
  $group            = 'lumberjack',
  $logdir           = '/var/log/lumberjack',
  $setfacl          = false,
  $ssl_ca_path      = 'puppet:///files/lumberjack-cert.pem',
  $version          = 'present',
  $window_size      = undef,
) {
  package { 'lumberjack':
    ensure => $version,
  }
  $lumberjack = hiera_hash('lumberjack::instances', undef)
  if $lumberjack {
    create_resources('lumberjack::instance', $lumberjack)
  }
  if $setfacl {
    warn( 'Setting ACLs is not implemented yet' )
  }
}
