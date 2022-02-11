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
  Variant[Boolean, Integer, Enum['absent'], String] $ensure,
  String                                            $key     = $title,
) {
  $_ensure = $ensure ? {
    Boolean => bool2num($ensure),
    default => $ensure,
  }

  $_changes = $ensure ? {
    'absent'  => "rm  ${key}",
    default   => "set ${key} '${_ensure}'",
  }

  augeas { "yum.conf_${key}":
    incl    => '/etc/yum.conf',
    lens    => 'Yum.lns',
    context => '/files/etc/yum.conf/main/',
    changes => $_changes,
  }
}
