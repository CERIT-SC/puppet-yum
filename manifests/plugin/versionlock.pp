class yum::plugin::versionlock (
  $ensure = present
) {
  yum::plugin { 'versionlock':
    ensure  => $ensure,
  }
}
