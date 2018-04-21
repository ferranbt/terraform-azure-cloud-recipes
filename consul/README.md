
# Consul

It uses [this]() module at here to deploy a cluster of Consul servers on a scale-set. 

## Bootstrapping

All the VMs deployed on the same private network are reachable with their hostname via DNS. All the VMs deployed on the same scale set will have the same prefix on the hostname. For example, for a scale-set with 3 servers and with prefix 'consul-', three VMs will be created with the next hostnames: 'consul-000001', 'consul-000002' and 'consul-000003'. During bootstrapping, the servers will try to join other servers with those DSN names using the 'retry-join' argument from consul.
