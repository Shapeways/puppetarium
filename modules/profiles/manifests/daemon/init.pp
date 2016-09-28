class profiles::daemon(
  $data = '',
  ) {

  include upstart

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
      exec            => "${workingdirectory}/bin/puppetariumtestdaemon --logdir ${workingdirectory}/logs",
      post_stop       => "exec sleep 60",
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
    }
    upstart::job { 'puppetariumtestdaemon' :
      ensure  => 'absent',
    }
  }
}
