# Define: yum::localinstall
#
# This definition installs or removes rpm's via file or url (e.g. not a repo).
# This can be prefereable to using just the rpm provider because it will pull
# in dependencies if available.
#
# Parameters:
#   [*ensure*]   - specifies if package group should be
#                  present (installed) or absent (purged)
#   [rpm_source] - file or url where RPM is available to the puppet agent.
#
# Actions:
#
# Requires:
#   RPM based system
#
# Sample usage:
#   yum::localinstall { 'epel-release':
#     ensure     => present,
#     rpm_source => 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm',
#   }
#
define yum::localinstall (
  $rpm_source = undef,
  $ensure = present
) {

  $install_message = 'Please note the resource title needs to be the same as the package name listed in the package manager.'

  Exec {
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    environment => 'LC_ALL=C'
  }

  if $rpm_source == undef {
    fail('Please pass a URI to an RPM you wish to install.')
  }


  case $ensure {
    present,installed: {
      exec { "yum-localinstall-${name}":
        command => "yum -y localinstall '${rpm_source}'; echo '${install_message}'",
        unless  => "yum -q list installed '${name}' | egrep -i '${name}'",
      }
    }

    absent,purged: {
      package { $name:
        ensure => $ensure,
      }
    }

    default: {
      fail("Invalid ensure state: ${ensure}")
    }
  }
}
