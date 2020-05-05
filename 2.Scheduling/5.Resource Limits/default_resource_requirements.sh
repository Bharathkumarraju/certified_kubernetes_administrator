When a pod is created the containers are assigned a default CPU request of 0.5 and memory of 256Mi.
For the POD to pick up those defaults
We must have first set those as default values for request and limit by creating a LimitRange in that namespace.

apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    type: Container



apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-limit-range
spec:
  limits:
  - default:
      cpu: 1
    defaultRequest:
      cpu: 0.5
    type: Container