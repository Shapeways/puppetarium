class profiles::config_files(
    $num_processes = $profiles::config_files::params::num_processes,
    $interfaces = $profiles::config_files::params::interfaces,
  ) inherits profiles::config_files::params {

  # Creating a directory and setting it's ownership / mode
  file { '/etc/config-profile' :
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '2775'
  } ->

  # Creating a directory and copying all files in a directory in the repo into the dir
  file { '/etc/config-profile/bind' :
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '2775',
    recurse => true,
    source  => 'puppet:///modules/profiles/config_files/bind',
  } ->

  # sym link to another file
  file { '/etc/config-profile/bind/active.conf' :
    ensure => 'link',
    target => '/etc/config-profile/bind/file_b.conf'
  } ->

  # Hard coded file
  file { '/etc/config-profile/hard_coded.conf' :
    content => 'Hard coded content for the file goes here
look, multiple lines',
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
  } ->

  # Templitized config file
  file { '/etc/config-profile/tempitized.conf' :
    content => template('profiles/config_files/template.conf.erb'),
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
  } ->

  # remove a file that should not exist
  file { '/etc/config-profile/empty-file' :
    ensure => 'absent',
  } -> 

  # remove a directory that should not exist
  file { '/etc/config-profile/empty-dir' :
    ensure => 'absent',
    force  => true,
  }
}