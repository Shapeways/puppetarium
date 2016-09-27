# gets $cronjobs from hiera
class profiles::cron (
  $cronjobs = $profiles::cron::params::cronjobs
) inherits profiles::cron::params {
  # use torrancew/puppet-cron module to create cronjobs in /etc/cron.d
  include cron

  package { ['gcc']:
    ensure  => 'installed',
  }

  # create cronjobber
  if (file('/usr/local/bin/cronjobber', '/dev/null') == '') {
    file { '/tmp/cronjobber.c':
      ensure  => 'present',
      source => 'puppet:///modules/profiles/cron/cronjobber.c',
    }
  }
  exec { 'compile_cronjobber':
    command => '/usr/bin/gcc -Wall /tmp/cronjobber.c -o /usr/local/bin/cronjobber; rm /tmp/cronjobber.c',
    creates => '/usr/local/bin/cronjobber',
  } ->
  file { '/var/log/cronjobber':
    ensure => 'directory',
  }

  if $cronjobs != '' {
    $cronjobs.each |String $name, Hash $cron| {
      file { "/var/log/cronjobber/${name}":
        ensure => 'directory',
      }
      if $cron['cronjobber'] {
        $job = $cron['cronjobber']
        $command = "/usr/local/bin/cronjobber -n ${name} -s /var/log/cronjobber/${name} -c \"${job}\""
      } else {
        $command = $cron['command']
      }
      cron::job { $name:
        name        => $name,
        ensure      => $cron['ensure'],
        minute      => $cron['minute'],
        hour        => $cron['hour'],
        date        => $cron['date'],
        month       => $cron['month'],
        weekday     => $cron['weekday'],
        user        => $cron['user'],
        command     => $command,
        environment => $cron['environment'],
      }
    }
  }
}
