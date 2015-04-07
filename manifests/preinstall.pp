# == Class icingaweb2::preinstall
#
class icingaweb2::preinstall {
  assert_private()

  if $::icingaweb2::manage_repo and $::icingaweb2::install_method == 'package' {
    case $::operatingsystem {
      'RedHat', 'CentOS': {
        ::icingaweb2::preinstall::redhat { 'icingaweb2':
          pkg_repo_version => $::icingaweb2::pkg_repo_version,
        }
      }

      default: {
        fail "Managing repositories for ${::operatingsystem} is not supported."
      }
    }
  }
}

