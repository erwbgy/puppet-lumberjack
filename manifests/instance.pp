define lumberjack::instance (
  $basedir          = $::lumberjack::basedir,
  $down             = $::lumberjack::down,
  $fields           = $::lumberjack::bind_address,
  $files            = $::lumberjack::files,
  $group            = $::lumberjack::group,
  $host             = $::lumberjack::host,
  $logdir           = $::lumberjack::logdir,
  $port             = $::lumberjack::port,
  $setfacl          = $::lumberjack::setfacl,
  $ssl_ca_path      = $::lumberjack::ssl_ca_path,
  $version          = $::lumberjack::version,
  $window_size      = $::lumberjack::window_size,
) {
  $user = $title

  include runit
  if ! defined(Runit::User[$user]) {
    runit::user { $user:
      basedir => $basedir,
      group   => $group,
    }
  }

  lumberjack::service { "${user}-lumberjack":
    basedir      => $basedir,
    down         => $down,
    fields       => $fields,
    files        => $files,
    group        => $group,
    host         => $host,
    logdir       => $logdir,
    port         => $port,
    setfacl      => $setfacl,
    ssl_ca_path  => $ssl_ca_path,
    version      => $version,
    window_size  => $window_size,
    user         => $user,
  }
}
