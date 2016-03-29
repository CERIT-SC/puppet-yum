
if "${::osfamily}" == 'RedHat' { # lint:ignore:only_variable_string

  # https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  # https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
  # https://dl.fedoraproject.org/pub/epel/epel-release-latest-5.noarch.rpm

  $rpm_source =  "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${::operatingsystemmajrelease}.noarch.rpm"


  yum::localinstall { 'epel-release':
    ensure     => present,
    rpm_source => $rpm_source,
  }

}
