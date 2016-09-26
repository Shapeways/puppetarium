class profiles::test{
	file { "/puppet-test-file" :
    content => template('profiles/test/test-file.erb'),
    owner => "root",
    group => "root",
    mode => "0440",
    }
}