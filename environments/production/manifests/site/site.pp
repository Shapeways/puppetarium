# Site manifest

# set up global $dc and $dc_provider variables
# (they normally depend on $fqdn and $hostname)
$dc = 'lab'
$dc_provider = 'sw'
notice("Welcome to dc $dc and dc_provider $dc_provider")

#Global default
node default {
}
