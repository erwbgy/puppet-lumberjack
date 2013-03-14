class lumberjack (
  $files,
  $host,
  $port,
  $basedir          = '/opt/lumberjack',
  $fields           = undef
  $down             = false,
  $group            = 'lumberjack',
  $logdir           = '/var/log/lumberjack',
  $setfacl          = false,
  $ssl_ca_path      = undef,
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
