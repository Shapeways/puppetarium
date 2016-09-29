class profiles::daemon::params(
  $data = {},
  ) {

  # this $data comes from profiles::daemon::params in puppetarium/data/modules/profiles/ 
  $daemon = $data['daemon']
  $daemonargs = $data['daemonargs']
  $workingdirectory = $data['workingdirectory']
  $user = $data['user']
  $group = $data['group']

  # lookup gets you environment-level or global data in puppetarium/data/environments/ or puppetarium/data/global/
  $active_dc  = lookup('env_active_dc')

}
