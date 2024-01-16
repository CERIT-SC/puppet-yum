class yum::params {
  case $facts['os']['family'] {
    'redhat': {
      $keepcache = false
      $debuglevel = 2
      $exactarch = true
      $obsoletes = true
      $gpgcheck = true
      $installonly_limit = 5
      $keep_kernel_devel = false
    }

    default: {
      fail("Unsupported OS family: ${facts['os']['family']}")
    }
  }
}
