# Puppet yum module

This module provides helpful definitions for dealing with *yum*.

### Requirements

Module has been tested on:

* Puppet 3.1.0
* CentOS 6.3

# Usage

### yum::gpgkey

Import/remove GPG RPM signing key.

Key defined in recipe (inline):

    yum::gpgkey { '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-smoketest1':
      ensure  => present,
      content => '-----BEGIN PGP PUBLIC KEY BLOCK-----
    ...
    -----END PGP PUBLIC KEY BLOCK-----',
    }

Key stored on Puppet fileserver:

    yum::gpgkey { '/etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org':
      ensure  => present,
      source  => 'puppet:///modules/elrepo/RPM-GPG-KEY-elrepo.org',
    }

### yum::plugin

Install or remove *yum* plugin:

    yum::plugin { 'versionlock':
      ensure  => present,
    }

### yum::versionlock

Locks explicitly specified packages from updates. Package name must
be precisely specified in format *`EPOCH:NAME-VERSION-RELEASE.ARCH`*.
Wild card in package name is allowed or automatically appended,
but be careful and always first check on target machine if your
package is matched correctly! Following definitions create same
configuration lines:

    yum::versionlock {
      '0:bash-4.1.2-9.el6_2.*':
        ensure  => present;
      '0:bash-4.1.2-9.el6_2.':
        ensure  => present;
    }

### yum::group

Install or remove *yum* package group:

    yum::plugin { 'X Window System':
      ensure  => present,
    }
