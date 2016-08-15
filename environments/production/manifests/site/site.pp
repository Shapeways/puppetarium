# Site manifest

#set up global $idc variable
if $fqdn =~ /nyc.shapeways.net$/ {
    $dc = 'nyc'
    notice("Welcome to NYC!")
} elsif $hostname =~ /-lab$/ {
    $dc = 'lab'
    notice("Welcome to DEBUG!")
} else {
    $dc = ''
}

#Global default
node default {
}
