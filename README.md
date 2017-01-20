# Puppet yum module

This module provides helpful definitions for dealing with *yum*.

### Requirements

Module has been tested on:

* Puppet 4.6.1 and newer
* CentOS 6, 7

# Usage

### yum

Manage main Yum configuration.

```puppet
class { 'yum':
  keep_kernel_devel => false|true,
  clean_old_kernels => false|true,
  config_options    => {
      my_cachedir => {
        ensure => '/home/waldo/.local/yum/cache',
        key    => 'cachedir',
      },
      gpgcheck    => true,
      debuglevel  => 5,
      assumeyes   => {
        ensure => 'absent',
      },
    },
  },
}
```

NOTE: The `config_options` parameter takes a Hash where keys are the names of `Yum::Config` resources and the values are either the direct `ensure` value (`gpgcheck` or `debuglevel` in the example above), or a Hash of the resource's attributes (`my_cachedir` or `assumeyes` in the example above).  Values may be Strings, Integers, or Booleans.  Booleans will be converted to either a `1` or `0`; use a quoted string to get a literal `true` or `false`.

If `installonly_limit` is changed, purging of old kernel packages is triggered if `clean_old_kernels` is `true`.

### yum::config

Manage yum.conf.

```puppet
yum::config { 'installonly_limit':
  ensure => 2,
}

yum::config { 'debuglevel':
  ensure => absent,
}
```

### yum::gpgkey

Import/remove GPG RPM signing key.

Key defined in recipe (inline):

```puppet
yum::gpgkey { '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-smoketest1':
  ensure  => present,
  content => '-----BEGIN PGP PUBLIC KEY BLOCK-----
...
-----END PGP PUBLIC KEY BLOCK-----',
}
```

Key stored on Puppet fileserver:

```puppet
yum::gpgkey { '/etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org':
  ensure => present,
  source => 'puppet:///modules/elrepo/RPM-GPG-KEY-elrepo.org',
}
```

### yum::plugin

Install or remove *yum* plugin:

```puppet
yum::plugin { 'versionlock':
  ensure => present,
}
```

### yum::versionlock

Locks explicitly specified packages from updates. Package name must
be precisely specified in format *`EPOCH:NAME-VERSION-RELEASE.ARCH`*.
Wild card in package name is allowed or automatically appended,
but be careful and always first check on target machine if your
package is matched correctly! Following definitions create same
configuration lines:

```puppet
yum::versionlock { '0:bash-4.1.2-9.el6_2.*':
  ensure => present,
}

yum::versionlock { '0:bash-4.1.2-9.el6_2.':
  ensure => present,
}
```

Correct name for installed package can be easily get by running e.g.:

```bash
$ rpm -q bash --qf '%|EPOCH?{%{EPOCH}}:{0}|:%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n'
0:bash-4.2.45-5.el7_0.4.x86_64
```

### yum::group

Install or remove *yum* package group:

```puppet
yum::group { 'X Window System':
  ensure  => present,
  timeout => 600,
}
```

### yum::install

Install or remove packages via *yum* install subcommand:

From URL:

```puppet
yum::install { 'package-name':
  ensure => present,
  source => 'http://path/to/package/filename.rpm',
}
```

From local filesystem:

```puppet
yum::install { 'package-name':
  ensure => present,
  source => '/path/to/package/filename.rpm',
}
```

Please note that resource name must be same as installed package name.

---

This module was donated by CERIT Scientific Cloud, <support@cerit-sc.cz> to Vox Pupuli
