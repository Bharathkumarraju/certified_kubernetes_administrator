$ docker build -t ubuntu-sleeper-ENTRYPOINT .

echo "Here sleep seconds are dynamic, we can specify any in commandline"
$ docker run -d ubuntu-sleeper-ENTRYPOINT 200

echo "if you won't specify sleep seconds then by default it will take 50 as specified in Dockerfile"
$ docker run -d ubuntu-sleeper-ENTRYPOINT

echo "what If you want to change the entrypoint also in the command line while running container"
$ docker run -d --entrypoint sleep2.0 ubuntu-sleeper-ENTRYPOINT 180