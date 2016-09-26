#Module Data Goes Here
Puppet uses the data stored in these YAML files to populate variables defined within modules. The `data/profiles` directory is defined by the `profiles` module as its data source according the priority list below. The list is ordered from highest priority to lowest priority.  

The data is stored in a hierarchy where the top level is data common to all nodes and each level below is specific to fewer and fewer nodes. The hierarchy is defined in `modules/profiles/hiera.yaml`. For the Puppetarium repository the contents of that file are as follows:

```yaml
---
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
    path: "common/*"
  ```

When Puppet performs a lookup for a specific node, the value of the data is based on this heirarchy and the `lookup_options` defined for the key/value in `data/profiles/common/$module_name.yaml`. The `lookup_options` allow you to define a merge strategy other than the default of first match wins (i.e. lookups would return values in the first file to contain the data).

Here is an example `lookup_options`:
```yaml
lookup_options:
  profiles::example::data:
    merge:
      strategy: deep
```

The `deep` fits our needs in most cases. It allows general and default configuration data to be put into `common/` while allowing certain elements of an array or hash to be overrode by more specific configuration data in higher priority YAML files.