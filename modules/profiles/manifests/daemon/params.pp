class profiles::daemon::params(
  $data = '',
  ) {

  $workingdirectory = $data['workingdirectory']
  $active_dc  = lookup('env_active_dc')

}
