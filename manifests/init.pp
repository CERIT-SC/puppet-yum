# A class to install and manage Yum configuration.
#
# @param clean_old_kernels Whether or not to purge old kernel version beyond the `keeponly_limit`.
# @param keep_kernel_devel Whether or not to keep kernel devel packages on old kernel purge.
# @param config_options A Hash where keys are the names of `Yum::Config` resources and the values
#   are either the direct `ensure` value, or a Hash of the resource's attributes.
#   @note Boolean values will be converted to either a `1` or `0`; use a quoted string to get a
#     literal `true` or `false`.
#
class yum (
  Boolean $clean_old_kernels = true,
  Boolean $keep_kernel_devel = false,
  Hash[String, Variant[String, Integer, Boolean, Hash[String, Variant[String, Integer, Boolean]]]] $config_options = { },
) {

  $module_metadata            = load_module_metadata($module_name)
  $supported_operatingsystems = $module_metadata['operatingsystem_support']
  $supported_os_names         = $supported_operatingsystems.map |$os| {
    $os['operatingsystem']
  }

  unless member($supported_os_names, $::os['name']) {
    fail("${::os['name']} not supported")
  }

  unless empty($config_options) {

    if has_key($config_options, 'installonly_limit') {
      assert_type(Variant[Integer, Hash[String, Integer]], $config_options['installonly_limit']) |$expected, $actual| {
        fail("The value or ensure for `\$yum::config_options[installonly_limit]` must be an Integer, but it is not.")
      }
    }

    $_normalized_config_options = $config_options.map |$key, $attrs| {
      $_ensure = $attrs ? {
        Hash    => $attrs[ensure],
        default => $attrs,
      }

      $_normalized_ensure = $_ensure ? {
        Boolean => Hash({ ensure => bool2num($_ensure) }), # lint:ignore:unquoted_string_in_selector
        default => Hash({ ensure => $_ensure }), # lint:ignore:unquoted_string_in_selector
      }

      $_normalized_attrs = $attrs ? {
        Hash    => merge($attrs, $_normalized_ensure),
        default => $_normalized_ensure,
      }

      Hash({ $key => $_normalized_attrs })
    }.reduce |$memo, $cfg_opt_hash| {
      merge($memo, $cfg_opt_hash)
    }

    $_normalized_config_options.each |$config, $attributes| {
      Resource['yum::config'] {
        $config: * => $attributes,
      }
    }
  }

  unless defined(Yum::Config['installonly_limit']) {
    yum::config { 'installonly_limit': ensure => '3' }
  }

  $_clean_old_kernels_subscribe = $clean_old_kernels ? {
    true    => Yum::Config['installonly_limit'],
    default => undef,
  }

  # cleanup old kernels
  ensure_packages(['yum-utils'])

  $_real_installonly_limit = $config_options['installonly_limit'] ? {
    Variant[String, Integer] => $config_options['installonly_limit'],
    Hash                     => $config_options['installonly_limit']['ensure'],
    default                  => '3',
  }

  $_pc_cmd = delete_undef_values([
    '/usr/bin/package-cleanup',
    '--oldkernels',
    "--count=${_real_installonly_limit}",
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
    subscribe   => $_clean_old_kernels_subscribe,
  }
}
