curl --header "Content-Type:application/json" --request POST --data \
'{"apiVersion":"v1", "kind": "Binding", "metadata": {"name": "nginx"}, "target": {"apiVersion": "v1", "kind": "Node", "name": "node02"}}' \
http://$SERVER/api/v1/namespaces/default/pods/$PODNAME/binding/