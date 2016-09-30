class profiles::daemon(
    $daemon = $profiles::daemon::params::daemon ,
    $daemonargs = $profiles::daemon::params::daemonargs ,
    $workingdirectory = $profiles::daemon::params::workingdirectory ,
    $user = $profiles::daemon::params::user ,
    $group = $profiles::daemon::params::group ,

    $active_dc = $profiles::daemon::params::active_dc ,
  ) inherits profiles::daemon::params {

  include upstart

  file { $daemon :
    source  => 'puppet:///modules/profiles/daemon/fakedaemon.sh',
    mode    => '0755',
    ensure  => 'file',
  }
 
  # Only define job (running, start on boot) if node is in the active datacenter
  if ($dc == $active_dc) {
    upstart::job { 'puppetariumtestdaemon' :
      description     => 'Upstart service for puppetarium test daemon.',
      version         => '1.0',
      respawn         => true,
      respawn_limit   => '5 10',
      user            => "${user}",
      group           => "${group}",
      chdir           => "${workingdirectory}",
      exec            => join(concat(["${daemon}"], $daemonargs), " "),
      post_stop       => "exec sleep 1",
      env             => { "PATH" => "${facts['path']}" },
      service_ensure  => 'running',
      service_enable  => true,
    }
  } else {
    # upstart module doesn't stop services if running - boo.
    # Stop the daemon if its init script exists and claims the daemon is running
    exec { 'stop puppetariumtestdaemon':
      command       => "stop puppetariumtestdaemon",
      path          => "${facts['path']}",
      onlyif        => [
                         "status puppetariumtestdaemon",
                         "status puppetariumtestdaemon | grep -q start/running",
                       ],
    } ->
    upstart::job { 'puppetariumtestdaemon' :
      ensure  => 'absent',
    }
  }
}
