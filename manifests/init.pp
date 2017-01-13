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
  Boolean                                 $keepcache         = false,
  Variant[Integer[0, 10], Enum['absent']] $debuglevel        = 2,
  Boolean                                 $exactarch         = true,
  Boolean                                 $obsoletes         = true,
  Boolean                                 $gpgcheck          = true,
  Variant[Integer[0], Enum['absent']]     $installonly_limit = 5,
  Boolean                                 $keep_kernel_devel = false,
  Boolean                                 $clean_old_kernels = true,
) {

  $module_metadata            = load_module_metadata($module_name)
  $supported_operatingsystems = $module_metadata['operatingsystem_support']
  $supported_os_names         = $supported_operatingsystems.map |$os| {
    $os['operatingsystem']
  }

  unless member($supported_os_names, $::os['name']) {
    fail("${::os['name']} not supported")
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
