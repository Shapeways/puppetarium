#Site manifest

#Do not add `default` node here, add it to site.pp

node 'puppetarium-idc1.idc1.shapeways.net' {
  include roles::example
}

#Catch-all for nyc.shapeways.net
node /nyc.shapeways.net$/ {
    include profiles::daemon
	include profiles::config_files
}
