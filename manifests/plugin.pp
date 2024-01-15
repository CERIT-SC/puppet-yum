# Define: yum::plugin
#
# This definition installs Yum plugin.
#
# Parameters:
#   [*ensure*]   - specifies if plugin should be present or absent
#   [*pkg_prefix*]
#   [*pkg_name*]
#
# Actions:
#
# Requires:
#   RPM based system
#
# Sample usage:
#   yum::plugin { 'versionlock':
#     ensure  => present,
#   }
#
define yum::plugin (
  String $ensure               = 'present',
  Optional[String] $pkg_prefix = undef,
  Optional[String] $pkg_name   = undef,
) {
  if $pkg_prefix {
    $_pkg_prefix = $pkg_prefix
  } else {
    $_pkg_prefix = $facts['os']['release']['major'] ? {
      5         => 'yum',
      default   => 'yum-plugin'
    }
  }

  $_pkg_name = $pkg_name ? {
    ''      => "${_pkg_prefix}-${name}",
    default => "${_pkg_prefix}-${pkg_name}"
  }

  package { $_pkg_name:
    ensure  => $ensure,
  }

  if ! defined(Yum::Config['plugins']) {
    yum::config { 'plugins':
      ensure => 1,
    }
  }
}
