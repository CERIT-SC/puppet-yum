# Class: yum
#
# Manage Yum configuration.
#
# Parameters:
#   [*keepcache*]         - Yum option keepcache
#   [*debuglevel*]        - Yum option debuglevel
#   [*exactarch*]         - Yum option exactarch
#   [*obsoletes*]         - Yum option obsoletes
#   [*gpgcheck*]          - Yum option gpgcheck
#   [*installonly_limit*] - Yum option installonly_limit
#   [*keep_kernel_devel*] - On old kernels purge keep devel packages.
#
# Actions:
#
# Requires:
#   RPM based system
#
# Sample usage:
#   class { 'yum':
#     installonly_limit => 2,
#   }
#
class yum (
  $keepcache         = $yum::params::keepcache,
  $debuglevel        = $yum::params::debuglevel,
  $exactarch         = $yum::params::exactarch,
  $obsoletes         = $yum::params::obsoletes,
  $gpgcheck          = $yum::params::gpgcheck,
  $installonly_limit = $yum::params::installonly_limit,
  $keep_kernel_devel = $yum::params::keep_kernel_devel,
  $clean_old_kernels = $yum::params::clean_old_kernels
) inherits yum::params {

  validate_bool($keepcache, $exactarch, $obsoletes, $gpgcheck)
  validate_bool($keep_kernel_devel, $clean_old_kernels)

  unless is_integer($installonly_limit) {
    validate_string($installonly_limit)
  }

  unless is_integer($debuglevel) {
    validate_string($debuglevel)
  }

  if $clean_old_kernels {
    $_installonly_limit_notify = Exec['package-cleanup_oldkernels']
  } else {
    $_installonly_limit_notify = undef
  }

  # configure Yum
  yum::config { 'keepcache':
    ensure => bool2num($keepcache),
  }

  yum::config { 'debuglevel':
    ensure => $debuglevel,
  }

  yum::config { 'exactarch':
    ensure => bool2num($exactarch),
  }

  yum::config { 'obsoletes':
    ensure => bool2num($obsoletes),
  }

  yum::config { 'gpgcheck':
    ensure => bool2num($gpgcheck),
  }

  yum::config { 'installonly_limit':
    ensure => $installonly_limit,
    notify => $_installonly_limit_notify,
  }

  # cleanup old kernels
  ensure_packages(['yum-utils'])

  $_pc_cmd = delete_undef_values([
    '/usr/bin/package-cleanup',
    '--oldkernels',
    "--count=${installonly_limit}",
    '-y',
    $keep_kernel_devel ? {
      true    => '--keepdevel',
      default => undef,
    },
  ])

  exec { 'package-cleanup_oldkernels':
    command     => shellquote($_pc_cmd),
    refreshonly => true,
    require     => Package['yum-utils'],
  }
}
