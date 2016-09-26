#Site manifest

#Do not add `default` node here, add it to site.pp

node 'puppetarium-idc1.idc1.shapeways.net' {
  include roles::example
}

#Catch-all for nyc.shapeways.net
node /idc1.shapeways.net$/ {
	include profiles::test
}
