# Yum

[![Build Status](https://travis-ci.org/voxpupuli/puppet-yum.png?branch=master)](https://travis-ci.org/voxpupuli/puppet-yum)

## Module description

This module provides helpful definitions for dealing with *yum*.

### Requirements

Module has been tested on:

* Puppet 4.6.1 and newer
* CentOS 6, 7

## Usage

### Manage global Yum configuration via the primary class

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

### Manage yum.conf entries via defined types

```puppet
yum::config { 'installonly_limit':
  ensure => 2,
}

yum::config { 'debuglevel':
  ensure => absent,
}
```

### Add/remove a GPG RPM signing key using an inline key block


```puppet
yum::gpgkey { '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-smoketest1':
  ensure  => present,
  content => '-----BEGIN PGP PUBLIC KEY BLOCK-----
...
-----END PGP PUBLIC KEY BLOCK-----',
}
```

### Add/remove a GPGP RPM signing key using a key stored on a Puppet fileserver

```puppet
yum::gpgkey { '/etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org':
  ensure => present,
  source => 'puppet:///modules/elrepo/RPM-GPG-KEY-elrepo.org',
}
```

### Install or remove *yum* plugin

```puppet
yum::plugin { 'versionlock':
  ensure => present,
}
```

### Lock a package with the *versionlock* plugin

Locks explicitly specified packages from updates. Package name must be precisely specified in format *`EPOCH:NAME-VERSION-RELEASE.ARCH`*. Wild card in package name is allowed provided it does not span a field seperator.

```puppet
yum::versionlock { '0:bash-4.1.2-9.el6_2.*':
  ensure => present,
}
```

Use the following command to retrieve a properly-formated string:

```sh
PACKAGE_NAME='bash'
rpm -q "$PACKAGE_NAME" --qf '%|EPOCH?{%{EPOCH}}:{0}|:%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n'
```

### Install or remove *yum* package group

```puppet
yum::group { 'X Window System':
  ensure  => present,
  timeout => 600,
}
```

### Install or remove packages via `yum install`

This is a workaround for [PUP-3323](https://tickets.puppetlabs.com/browse/PUP-3323).  It enables the installation of packages from non-repo sources while still providing dependency resolution.  For example, say there is a package *foo* that requires the package *bar*.  *bar* is in a Yum repository and *foo* is stored on a stand-alone HTTP server.  Using the standard providers for the `Package` resource type, `rpm` and `yum`, the `rpm` provider would be required to install *foo*, because only it can install from a non-repo source, i.e., a URL.  However, since the `rpm` provider cannot do dependency resolution, it would fail on its own unless *bar* was already installed.  This workaround enables *foo* to be installed without having to define its dependencies in Puppet.

From URL:

```puppet
yum::install { 'package-name':
  ensure => present,
  source => 'http://example.com/path/to/package/filename.rpm',
}
```

From local filesystem:

```puppet
yum::install { 'package-name':
  ensure => present,
  source => 'file:///path/to/package/filename.rpm',
}
```

Please note that resource name must be same as installed package name.

---

This module was donated by CERIT Scientific Cloud, <support@cerit-sc.cz> to Vox Pupuli
