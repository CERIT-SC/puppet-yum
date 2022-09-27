#
# @summary This definition manages yum.conf
#
# @param ensure specifies value or absent keyword
# @param key alternative conf. key (defaults to name)
#
# @example configure installonly limit
#   yum::config { 'installonly_limit':
#     ensure => 2,
#   }
#
# @example remove a configuration
#   yum::config { 'debuglevel':
#     ensure => absent,
#   }
#
define yum::config (
  Variant[Boolean, Integer, Enum['absent'], String, Sensitive[String]] $ensure,
  String                                            $key     = $title,
) {
  $_ensure = $ensure ? {
    Boolean   => bool2num($ensure),
    Sensitive => $ensure.unwrap,
    default   => $ensure,
  }

  $_changes = $ensure ? {
    'absent'  => "rm  ${key}",
    default   => "set ${key} '${_ensure}'",
  }

  $_show_diff = $ensure ? {
    Sensitive => false,
    default   => true,
  }

  augeas { "yum.conf_${key}":
    incl      => '/etc/yum.conf',
    lens      => 'Yum.lns',
    context   => '/files/etc/yum.conf/main/',
    changes   => $_changes,
    show_diff => $_show_diff,
  }
}
