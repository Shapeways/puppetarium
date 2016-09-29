#Site manifest

#Do not add `default` node here, add it to site.pp

node 'example.nyc.shapeways.net' {
  include profiles::example
}

#Catch-all for nyc.shapeways.net
node /nyc.shapeways.net$/ {
	include profiles::test
    include profiles::daemon
}
