#Site manifest

#Do not add `default` node here, add it to site.pp

#Catch-all for nyc.shapeways.net
node /nyc.shapeways.net$/ {
}

node 'example.nyc.shapeways.net' {
  include profiles::example
}
