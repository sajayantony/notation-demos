# Notation Demos

The repository contains demos for [Notation](https://github.com/notaryproject/notation) CLI of the Notary Project. 

## Running the demos

### Prerequisites

- [docker](https://docs.docker.com/get-docker/)
- [oras](https://oras.land/docs/how_to_guides/installation)
- [pv](https://ss64.com/bash/pv.html)
- [jq](https://stedolan.github.io/jq/)

The demo requires an OCI registry. For this we use zot registry. The registry is run as container and the network is created between the notation-demo image and the demo-registry container. 

To avoid passing --plain-http flags and other --insecure flags, the notation-demo container runs socat to forward the traffic to the registry container from localhost.

![Notation Demos](images/sign-demo.gif)

## Credits

The demo is based of @thockin's [micro-demos]

[micro-demos]: https://github.com/thockin/micro-demos