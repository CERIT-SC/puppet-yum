# Define: yum::versionlock
#
# This definition locks package from updates.
#
# Parameters:
#   [*ensure*] - specifies if versionlock should be present, absent or exclude
#
# Actions:
#
# Requires:
#   RPM based system, Yum versionlock plugin
#
# Sample usage:
#   yum::versionlock { '0:bash-4.1.2-9.el6_2.*':
#     ensure  => present,
#   }
#
define yum::versionlock (
  $ensure = present,
) {
  include ::yum::plugin::versionlock

  if ($name =~ /^[0-9]+:.+\*$/) {
    $line = $name
  } elsif ($name =~ /^[0-9]+:.+-.+-.+\./) {
    $line= "${name}*"
  } else {
    fail('Package name must be formated as \'EPOCH:NAME-VERSION-RELEASE.ARCH\'')
  }

  $line_prefix = $ensure ? {
    'exclude' => '!',
    default => '',
  }

  case $ensure {
    'present','exclude': {
      concat::fragment { "yum-versionlock-${name}":
        content => "${line_prefix}${line}\n",
        target  => $yum::plugin::versionlock::path,
      }
    }
    'absent':{
      # fragment will be removed
    }
    default: {
      fail("Invalid ensure state: ${ensure}")
    }
  }
}
