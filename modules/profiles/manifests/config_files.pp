class profiles::config_files{

  file { "/ect/config-profile" :
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => "2775"
  } ->
  file { "/etc/config-profile/tempitized.conf" :
    content => template('profiles/config_files/template.conf.erb'),
    owner => "root",
    group => "root",
    mode => "0440",
    }
}