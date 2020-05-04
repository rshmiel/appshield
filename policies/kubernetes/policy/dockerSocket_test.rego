package main

test_docker_socket {
  checkDockerSocket with input as {
    "kind": "Deployment",
    "spec": {
      "volumes": [
        {
          "name": "dockersock",
          "hostPath": {
            "path": "/var/run/docker.sock"
          }
        }
      ]
    }
  }
}

test_docker_socket_some_other_volume {
  checkDockerSocket with input as {
    "kind": "Deployment",
    "spec": {
      "volumes": [
        {
          "name": "dockersock",
          "hostPath": {
            "path": "/some/run/docker.sock"
          }
        }
      ]
    }
  }
}

test_docker_socket_no_volumes {
  checkDockerSocket with input as {
    "kind": "Deployment",
    "spec": {
    }
  }
}
