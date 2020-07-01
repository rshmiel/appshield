package main

import data.lib.kubernetes

default failPrivileged = false

# getPrivilegedContainers returns all containers which have
# securityContext.privileged set to true.
getPrivilegedContainers[container] {
  allContainers := kubernetes.containers[_]
  allContainers.securityContext.privileged == true
  container := allContainers.name
}

# failPrivileged is true if there is ANY container with securityContext.privileged
# set to true.
failPrivileged {
  count(getPrivilegedContainers) > 0
}

deny[msg] {
  failPrivileged

  msg := kubernetes.format(
    sprintf(
      "container %s of %s %s in %s namespace should set securityContext.privileged to false",
      [getPrivilegedContainers[_], lower(kubernetes.kind), kubernetes.name, kubernetes.namespace]
    )
  )
}