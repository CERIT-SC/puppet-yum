# Puppet yum module

This module provides helpful definitions for dealing with Yum.

### Requirements

Module has been tested on:

* Puppet 3.0
* CentOS 6.3

# Usage

### yum::gpgkey

Import/remove GPG RPM signing key.

Key defined in recipe (inline):

    yum::gpgkey { "/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-smoketest1":
      ensure  => present,
      content => '-----BEGIN PGP PUBLIC KEY BLOCK-----
    ...
    -----END PGP PUBLIC KEY BLOCK-----',
    }

Key stored on Puppet fileserver:

    yum::gpgkey { "/etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org":
      ensure  => present,
      source  => 'puppet:///modules/elrepo/RPM-GPG-KEY-elrepo.org',
    }

### yum::plugin

Install or remove Yum plugin:

    yum::plugin { "versionlock":
      ensure  => present
    }

### yum::versionlock

Locks explicitly specified packages from updates. Package name must
be precisely specified in format *`EPOCH:NAME-VERSION-RELEASE.ARCH`*.

    yum::versionlock { '0:bash-4.1.2-9.el6_2':
      ensure  => present,
    }

