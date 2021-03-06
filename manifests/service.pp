define lumberjack::service (
  $basedir,
  $down,
  $fields,
  $files,
  $host,
  $group,
  $logdir,
  $port,
  $setfacl,
  $ssl_ca_path,
  $version,
  $window_size,
  $user,
) {
  if $ssl_ca_path =~ /^puppet:/ {
    file { "${basedir}/cert.pem":
      ensure  => present,
      mode    => '0444',
      owner   => $user,
      group   => $group,
      source  => $ssl_ca_path,
    }
    $cert_path = "${basedir}/cert.pem"
  }
  else {
    $cert_path = $ssl_ca_path
  }
  $product_dir = '/opt/lumberjack'
  include runit
  runit::service { "${user}-lumberjack":
    service     => 'lumberjack',
    basedir     => $basedir,
    logdir      => $logdir,
    user        => $user,
    group       => $group,
    down        => $down,
    timestamp   => true,
  }
  file { "${basedir}/runit/lumberjack/run":
    ensure  => present,
    mode    => '0555',
    owner   => $user,
    group   => $group,
    content => template('lumberjack/run.erb'),
    require => Runit::Service["${user}-lumberjack"],
  }
  file { "${basedir}/service/lumberjack":
    ensure  => link,
    target  => "${basedir}/runit/lumberjack",
    owner   => $user,
    group   => $group,
    replace => false,
    require => Runit::Service["${user}-lumberjack"],
  }
}
