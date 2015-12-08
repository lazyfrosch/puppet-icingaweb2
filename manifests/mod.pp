# == Class: icingaweb2::mod
#
# Provides default basic resources for any module.
#
define icingaweb2::mod(
  $module_path = undef,
) {
  require ::icingaweb2

  if ! $module_path {
    $_module_path = "${::icingaweb2::params::web_root}/modules/${name}"
  }
  else {
    $_module_path = $module_path
  }

  File {
    require => Class['::icingaweb2::config'],
    owner => $::icingaweb2::config_user,
    group => $::icingaweb2::config_group,
    mode  => $::icingaweb2::config_file_mode,
  }

  file { "icingaweb2 module ${name} enable":
    ensure => symlink,
    path   => "${::icingaweb2::config_dir}/enabledModules/${name}",
    target => $_module_path,
  }

  file { "icingaweb2 module ${name} config_dir":
    ensure => directory,
    path   => "${::icingaweb2::config_dir}/modules/${name}",
  }

}