So you decide to have your own scheduling algorithm to place pods on nodes.
So that you can add your own custom conditions and checks on it.

Kubernetes is highly extensible.
i.e. you can write your own kubernetes scheduler program, package it and deploy it as the default scheduler.
or an additional scheduler in the kubernetes cluster. That way all of the other applications can go through
the default scheduler.

However one specific application can use your custom scheduler.
your kubernetes cluster can have multiple schedulers at the same time.

When creating a POD or a Deployment you can instruct the kubernetes to have the POD scheduled by specific scheduler.

How to use custom scheduler:
------------------------------>
kube-scheduler.service:  --> This is the default scheduler
ExecStart=/usr/local/bin/kube-scheduler \\
    --config=/etc/kubernetes/config/kube-scheduler.yaml \\
    --scheduler-name=default-scheduler

To Deploy an Additional scheduler set the scheduler name to custom name as below.

my-custom-scheduler.service:
ExecStart=/usr/local/bin/kube-scheduler \\
    --config=/etc/kubernetes/config/kube-scheduler.yaml \\
    --scheduler-name=my-custom-scheduler





