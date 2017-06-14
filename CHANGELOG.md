# Change log

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not impact the functionality of the module.

## [v2.0.0](https://github.com/voxpupuli/puppet-yum/tree/v2.0.0) (2017-06-14)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v1.0.0...v2.0.0)

**Implemented enhancements:**

- Add module data for EPEL [\#44](https://github.com/voxpupuli/puppet-yum/pull/44) ([lamawithonel](https://github.com/lamawithonel))
- Manage yumrepos via data [\#40](https://github.com/voxpupuli/puppet-yum/pull/40) ([lamawithonel](https://github.com/lamawithonel))
- Update README.md [\#39](https://github.com/voxpupuli/puppet-yum/pull/39) ([Yuav](https://github.com/Yuav))
- Be more strict about versionlock strings [\#38](https://github.com/voxpupuli/puppet-yum/pull/38) ([lamawithonel](https://github.com/lamawithonel))
- BREAKING: Config create resources pattern [\#37](https://github.com/voxpupuli/puppet-yum/pull/37) ([lamawithonel](https://github.com/lamawithonel))

**Fixed bugs:**

- Versionlock release string may contain dots [\#49](https://github.com/voxpupuli/puppet-yum/pull/49) ([traylenator](https://github.com/traylenator))
- Fix typo. [\#45](https://github.com/voxpupuli/puppet-yum/pull/45) ([johntconklin](https://github.com/johntconklin))
- Remove `section` parameter from `yum::config` [\#33](https://github.com/voxpupuli/puppet-yum/pull/33) ([lamawithonel](https://github.com/lamawithonel))
- Comma seperated values puppet3 [\#31](https://github.com/voxpupuli/puppet-yum/pull/31) ([matonb](https://github.com/matonb))

**Closed issues:**

- Class\[Yum\]: has no parameter named 'config\_options' [\#48](https://github.com/voxpupuli/puppet-yum/issues/48)
- Augeas errors arise when applying yum settings on Cent OS 6 clients [\#47](https://github.com/voxpupuli/puppet-yum/issues/47)
- Remove individual configs from init.pp, use create\_resources pattern instead [\#36](https://github.com/voxpupuli/puppet-yum/issues/36)
- Fix versionlock regex [\#35](https://github.com/voxpupuli/puppet-yum/issues/35)
-  yum::config fails with comma separated values [\#21](https://github.com/voxpupuli/puppet-yum/issues/21)

## [v1.0.0](https://github.com/voxpupuli/puppet-yum/tree/v1.0.0) (2017-01-14)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v0.10.0...v1.0.0)

**Implemented enhancements:**

- Update for Puppet 4, remove support for Puppet 3 [\#25](https://github.com/voxpupuli/puppet-yum/pull/25) ([lamawithonel](https://github.com/lamawithonel))

**Merged pull requests:**

- Release 1.0.0 [\#30](https://github.com/voxpupuli/puppet-yum/pull/30) ([bastelfreak](https://github.com/bastelfreak))
- Comma separated values for assumeyes [\#29](https://github.com/voxpupuli/puppet-yum/pull/29) ([matonb](https://github.com/matonb))

## [v0.10.0](https://github.com/voxpupuli/puppet-yum/tree/v0.10.0) (2017-01-11)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v0.9.15...v0.10.0)

**Implemented enhancements:**

- Bump min version\_requirement for Puppet + deps [\#22](https://github.com/voxpupuli/puppet-yum/pull/22) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Add parameter clean\_old\_kernels [\#20](https://github.com/voxpupuli/puppet-yum/pull/20) ([treydock](https://github.com/treydock))
- Correct format of fixtures file. [\#14](https://github.com/voxpupuli/puppet-yum/pull/14) ([traylenator](https://github.com/traylenator))

## [v0.9.15](https://github.com/voxpupuli/puppet-yum/tree/v0.9.15) (2016-09-26)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v0.9.14...v0.9.15)

**Merged pull requests:**

- Update changelog and version [\#12](https://github.com/voxpupuli/puppet-yum/pull/12) ([Yuav](https://github.com/Yuav))
- Added basic spec tests [\#11](https://github.com/voxpupuli/puppet-yum/pull/11) ([Yuav](https://github.com/Yuav))
- Bug: Puppet creates empty key files when using Hiera and create\_resources\(\) [\#7](https://github.com/voxpupuli/puppet-yum/pull/7) ([lklimek](https://github.com/lklimek))
- Manage yum::versionlock with concat [\#6](https://github.com/voxpupuli/puppet-yum/pull/6) ([jpoittevin](https://github.com/jpoittevin))

## [v0.9.14](https://github.com/voxpupuli/puppet-yum/tree/v0.9.14) (2016-08-15)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v0.9.13...v0.9.14)

**Merged pull requests:**

- Release 0.9.14 [\#5](https://github.com/voxpupuli/puppet-yum/pull/5) ([jyaworski](https://github.com/jyaworski))

## [v0.9.13](https://github.com/voxpupuli/puppet-yum/tree/v0.9.13) (2016-08-15)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v0.9.12...v0.9.13)

**Merged pull requests:**

- Release 0.9.13 [\#4](https://github.com/voxpupuli/puppet-yum/pull/4) ([jyaworski](https://github.com/jyaworski))

## [v0.9.12](https://github.com/voxpupuli/puppet-yum/tree/v0.9.12) (2016-08-12)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v0.9.11...v0.9.12)

## [v0.9.11](https://github.com/voxpupuli/puppet-yum/tree/v0.9.11) (2016-08-12)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v0.9.10...v0.9.11)

## [v0.9.10](https://github.com/voxpupuli/puppet-yum/tree/v0.9.10) (2016-08-12)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v0.9.9...v0.9.10)

## [v0.9.9](https://github.com/voxpupuli/puppet-yum/tree/v0.9.9) (2016-08-12)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/v0.9.8...v0.9.9)

## [v0.9.8](https://github.com/voxpupuli/puppet-yum/tree/v0.9.8) (2016-08-04)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/0.9.8...v0.9.8)

## [0.9.8](https://github.com/voxpupuli/puppet-yum/tree/0.9.8) (2016-05-30)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/0.9.7...0.9.8)

## [0.9.7](https://github.com/voxpupuli/puppet-yum/tree/0.9.7) (2016-05-30)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/0.9.6...0.9.7)

## [0.9.6](https://github.com/voxpupuli/puppet-yum/tree/0.9.6) (2015-04-29)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/0.9.5...0.9.6)

## [0.9.5](https://github.com/voxpupuli/puppet-yum/tree/0.9.5) (2015-04-07)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/0.9.4...0.9.5)

## [0.9.4](https://github.com/voxpupuli/puppet-yum/tree/0.9.4) (2014-12-08)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/0.9.3...0.9.4)

## [0.9.3](https://github.com/voxpupuli/puppet-yum/tree/0.9.3) (2014-11-06)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/0.9.2...0.9.3)

## [0.9.2](https://github.com/voxpupuli/puppet-yum/tree/0.9.2) (2014-09-02)
[Full Changelog](https://github.com/voxpupuli/puppet-yum/compare/0.9.1...0.9.2)

## [0.9.1](https://github.com/voxpupuli/puppet-yum/tree/0.9.1) (2014-08-20)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*