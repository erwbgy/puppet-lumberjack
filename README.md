# puppet-lumberjack

Puppet module to install Apache Tomcat and run instances as Runit services
under one or more users.

The recommended usage is to place the configuration is hiera and just:

    include lumberjack

Example 1: hiera config with a single instance using defaults:

    lumberjack::instances:
      lumberjack:
        files:
          - '/var/log/messages'
          - '/var/log/secure'
        host: 'loghost.domain.com'
        port: '11100'

Example 2: hiera config with multiple instances with defaults and instance values:

    lumberjack::group:     'lumberjack'
    lumberjack::setfacl:   true
    lumberjack::version:   '0.0.25'
    
    lumberjack::instances:
      lumberjack1:
        basedir:      '/apps/lumberjack1'
        fields:
          hostname:   %{hostname}
        files:
          - '/apps/tomcat1/logs/app1/app.log'
        host:         'loghost1.domain.com'
        logdir:       '/apps/lumberjack1/logs'
        port:         '11100'
        ssl_ca_path:  '/apps/lumberjack1/cert.pem'
      lumberjack2:
        basedir:      '/apps/lumberjack2'
        files:
          - '/var/log/squid/access.log'
        host:         'loghost2.domain.com'
        logdir:       '/apps/lumberjack2/logs'
        port:         '11100'
        ssl_ca_path:  '/apps/lumberjack2/cert.pem'

## lumberjack parameters

*basedir*: The base runtime directory. Default: '/opt/lumberjack'

*down*: Whether or not Runit services are down by default.

*fields*: Key-value mappings added to every line.

*files*: The list of files to monitor. **Required**

*group*: The runtime user''s primary group. Default: 'lumberjack',

*host*: The hostname of the server to send lumberjack messages to. (This can be a comma-separated list of hostnames.) **Required**

*logdir*: The runtime log directory. Default: '/var/logs/lumberjack'

*port*: The port to connect to on the lumberjack server. **Required**

*setfacl*: Whether or not to set file system ACLs on the specified files (and their directories) to enable the runtime user to read each file. Default: false

*ssl_ca_path*: The path to the file containing the server''s SSL certificate. Default: '$basedir/cert.pem'

*version*: The version of the lumberjack package to install (eg. '0.0.25'). Default: 'present'

*window_size*: The maximum number of outstanding messages to send before we will wait for an acknowledgement.

## lumberjack::instance parameters

*title*: The user the instance runs as

Plus all of the parameters specified in 'lumberjack parameters' above.

It usually makes sense to specify basedir, logdir and files.

## Lumberjack packages

This module assumes that a package called 'lumberjack' is available through
your normal package repository.  See https://github.com/jordansissel/lumberjack
for details of how build RPM and DEB packages.

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-lumberjack
