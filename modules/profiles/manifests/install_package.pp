class profiles::install_package() {
  # make sure the package telnet is installed
  package {
    'telnet': ensure => 'installed'
  }
}
