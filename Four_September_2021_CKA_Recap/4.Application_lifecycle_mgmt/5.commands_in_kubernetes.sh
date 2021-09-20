How to specify arguments in pod definition file

apiVersion: v1
kind: Pod
metadata:
  labels:
    run: ubuntu-sleeper
  name: ubuntu-sleeper
spec:
  containers:
  - image: ubuntu-sleeper-entry-cmd
    name: ubuntu-sleeper
    command: ["sleep2.0"] # It overwrites the ENTRYPOINT in docker
    args: ["35"] # It overwrites the CMD field in docker