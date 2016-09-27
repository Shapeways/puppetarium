Roles

Guidelines:
*Roles are an abstraction help with organization of nodes.
*One role per host.
*Roles should not handle dependencies between profiles (those should be handled by the profile with the dependency).
*You can use conditional logic in a role to optionally include a needed profile (use a fact or custom data).
*If absolutely necessary, you can inherit a role to differentiate a new role, but conditional logic is preferred.
*role::base should be minimal enough to be successfully applied to all machines.
