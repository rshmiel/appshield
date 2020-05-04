package main

import data.lib.kubernetes

name = input.metadata.name

# Default to false if volume is undefined
# Required for OPA tests
default checkDockerSocket = false
 
checkDockerSocket {
  kubernetes.is_deployment
  input.spec.volumes[_].hostPath.path == "/var/run/docker.sock"
}

deny[msg] {
  checkDockerSocket
  msg = sprintf("%s should not mount /var/run/docker.socker", [name])
}
