
# Parity cluster

To run this repo it is required to have a private network (base) and a cluster of consul servers (consul) reachable via DNS.

Deploy a scale set of [Parity](https://github.com/paritytech/parity) nodes which are registered in a Consul cluster for service discovery. An external monitor service runs alongside every node to check the syncing process (relying on data from etherscan.io). If at any time the node is not synced, Consull will mark that node as not healthy. 

This recipe also deploys an [Nginx](https://www.nginx.com/) load balancer to provide a single HTTPS entrypoint for the Parity cluster with sticky sessions so that users are always directed to the same machine. It uses [Consul template](https://github.com/hashicorp/consul-template) to automatically update Nginx and remove or add nodes from the configuration depending on their healthiness. The public IP from the load balancer will be recorded into a valid domain in DNSimple.

This module requires a valid Azure and DNSimple token.
