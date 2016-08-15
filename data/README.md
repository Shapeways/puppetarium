#Module Data Goes Here
Puppet uses the data stored in these YAML files to populate variables defined within modules.

The data is stored in a hierarchy where the top level is data common to all nodes and each level below is specific to fewer and fewer nodes. The hierarchy is defined in `modules/profiles/hiera.yaml`. For the Puppetarium repository the contents of that file are as follows:

```---
version: 4
datadir: "../../data/profiles"
hierarchy:
  - name: "DC Nodes Immutable"
    backend: yaml
    path: "nodes/%{dc}/%{hostname}-immutable"
  - name: "DC Nodes"
    backend: yaml
    path: "nodes/%{dc}/%{hostname}"
  - name: "DC specific data"
    backend: yaml
    path: "locations/%{dc}"
  - name: "Common to all nodes"
    backend: yaml
    path: "common/*"```

When Puppet performs a lookup for a specific node, the value of the data is determined based on this heirarchy and the `lookup_options` defined for the key/value in `data/profiles/common/$module_name.yaml`.