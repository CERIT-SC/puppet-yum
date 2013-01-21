# Define: yum::versionlock
#
# This definition locks package from updates.
#
# Parameters:
#   [*ensure*] - specifies if versionlock should be present, absent or exclude
#   [*path*]   - configuration of Yum plugin versionlock
#
# Actions:
#
# Requires:
#   RPM based system, Yum versionlock plugin
#
# Sample usage:
#   yum::versionlock { '0:bash-4.1.2-9.el6_2':
#     ensure  => present,
#   }
#
define yum::versionlock (
	$ensure	= present,
	$path	= '/etc/yum/pluginconf.d/versionlock.list'
) {
	require	stdlib
	require yum::plugin::versionlock

	if ($name !~ /^[0-9]:.+-.+-.+\./) {
		fail("Package name must be explicitly specified as 'EPOCH:NAME-VERSION-RELEASE.ARCH'")
	}

	case $ensure {
		present,absent,exclude: {
			if ($ensure == present) or ($ensure == absent) {
				file_line { "versionlock.list-${name}":
					line	=> "${name}*",
					path	=> $path,
					ensure	=> $ensure,
				}
			}
		
			if ($ensure == exclude) or ($ensure == absent) {
				file_line { "versionlock.list-!${name}":
					line	=> "!${name}*",
					path	=> $path,
					ensure	=> $ensure,
				}
			}
		}

		default: {
			fail("Invalid ensure state: ${ensure}")
		}
	}
}
