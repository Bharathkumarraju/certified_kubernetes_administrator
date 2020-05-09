master $ kubectl apply -f ubuntu-sleeper-2.yaml
pod/ubuntu-sleeper-2 created
master $

Question:
---------->
Create a pod with the given specifications. By default it displays a 'blue' background.
Set the given command line arguments to change it to 'green'

Pod Name: webapp-green
Image: kodekloud/webapp-color
Command line arguments: --color=green


master $ kubectl apply -f webapp-color-green.yaml
pod/webapp-green createdmaster $