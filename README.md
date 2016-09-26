# puppetarium
Examples of modern Puppet (4.5) usage and techniques using hiera-like (Puppet Lookup) data

An attempt to collect examples of best practices for modern Puppet development.

# TODO:
* Don't access class or external data directly from within classes, use params.pp / inherit to encapsulate data lookups
* Don't rely on Puppet's file server for artifacts, use a repo
* you can debug erb templates with <%= scope.function_warning(["list:",list]) %>

