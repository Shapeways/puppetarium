# Site manifest

#set up global $idc variable
if $fqdn =~ /nyc.shapeways.net$/ {
    $provider = 'sw'
    $dc = 'nyc'
    notice("Welcome to NYC!")
} elsif $hostname =~ /-aws1a-euwest$/ {
    $provider = 'aws'
    $dc = 'aws1a-euwest'
    notice("Welcome to AWS EU West 1a!")
} elsif $hostname =~ /-lab$/ {
    $provider = 'sw'
    $dc = 'lab'
    notice("Welcome to DEBUG!")
} else {
    $dc = ''
    $provider = ''
}

#Global default
node default {
}
