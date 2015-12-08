# == Class icingaweb2::mod::monitoring
#
class icingaweb2::mod::monitoring (
  $resource_name        = 'icinga_ido',
  $protected_customvars = '*pw*,*pass*,community',
  $commandtransport_type = 'local',
  $commandtransport_path = '/var/run/icinga2/cmd/icinga2.cmd',
) {
  require ::icingaweb2

  if $::osfamily == 'Debian' {
    ensure_packages(['icingaweb2-module-monitoring'])
  }

  ::icingaweb2::mod { 'monitoring':  }

  $config_path = "${::icingaweb2::config_dir}/modules/monitoring"
  $config = "${config_path}/config.ini"
  $backends = "${config_path}/backends.ini"
  $commandtransports = "${config_path}/commandtransports.ini"

  Ini_Setting {
    ensure  => present,
    require => File[$config_path],
  }

  # config
  ini_setting { 'protected_customvars':
    path    => $config,
    section => 'security',
    setting => 'protected_customvars',
    value   => $protected_customvars,
  }

  # backend
  ini_setting { 'backend_type':
    path    => $backends,
    section => 'icinga_ido',
    setting => 'type',
    value   => 'ido',
  }
  ini_setting { 'backend_resource':
    path    => $backends,
    section => 'icinga_ido',
    setting => 'resource',
    value   => $resource_name,
  }

  # command transport
  ini_setting { 'commandtransport_type':
    path    => $commandtransports,
    section => 'icinga2',
    setting => 'transport',
    value   => $commandtransport_type,
  }
  ini_setting { 'commandtransport_path':
    path    => $commandtransports,
    section => 'icinga2',
    setting => 'path',
    value   => $commandtransport_path,
  }



}

