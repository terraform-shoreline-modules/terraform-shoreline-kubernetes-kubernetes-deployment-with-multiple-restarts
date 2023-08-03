
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Kubernetes deployment with multiple restarts
---

The incident type of "Kubernetes deployment with multiple restarts" indicates that a Kubernetes deployment has experienced multiple restarts within a certain timeframe, which is usually indicative of a problem. Kubernetes is a popular container orchestration platform that automates the deployment, scaling, and management of containerized applications. When a deployment experiences multiple restarts, it can impact the availability and performance of the application, and can be a sign of underlying issues that need to be addressed. This incident type is typically monitored and managed by DevOps teams responsible for ensuring the health and reliability of Kubernetes-based applications.

### Parameters
```shell
# Environment Variables

export NAMESPACE="PLACEHOLDER"

export DEPLOYMENT_NAME="PLACEHOLDER"

export POD_NAME="PLACEHOLDER"

export CONTAINER_NAME="PLACEHOLDER"

export APP_LABEL="PLACEHOLDER"

```

## Debug

### Check the status of the Kubernetes Deployment
```shell
kubectl get deploy ${DEPLOYMENT_NAME} -n ${NAMESPACE}
```

### Check the logs of a Kubernetes Pod
```shell
kubectl logs ${POD_NAME} -c ${CONTAINER_NAME} -n ${NAMESPACE}
```

### Get detailed information about a Kubernetes Pod
```shell
kubectl describe pod ${POD_NAME} -n ${NAMESPACE}
```

### Check the status of a Kubernetes Pod
```shell
kubectl get pod ${POD_NAME} -n ${NAMESPACE}
```

### Check the events related to a Kubernetes Pod
```shell
kubectl get events --field-selector involvedObject.name=${POD_NAME} -n ${NAMESPACE}
```

### Check the resource utilization of a Kubernetes Pod
```shell
kubectl top pod ${POD_NAME} -n ${NAMESPACE}
```

### Check the status of all Kubernetes Pods in a Deployment
```shell
kubectl get pods -l app=${APP_LABEL} -n ${NAMESPACE}
```

### Check the resource utilization of all Kubernetes Pods in a Deployment
```shell
kubectl top pods -l app=${APP_LABEL} -n ${NAMESPACE}
```

### Check the logs of all Kubernetes Pods in a Deployment
```shell
kubectl logs -l app=${APP_LABEL} -c ${CONTAINER_NAME} -n ${NAMESPACE}
```

### Get detailed information about all Kubernetes Pods in a Deployment
```shell
kubectl describe pods -l app=${APP_LABEL} -n ${NAMESPACE}
```

### Check the events related to all Kubernetes Pods in a Deployment
```shell
kubectl get events --field-selector involvedObject.name=${POD_NAME} -n ${NAMESPACE}
```

## Repair

### Increase resource allocation: If the root cause is identified as insufficient resources, increase the allocation of CPU, memory, or other resources to the Kubernetes deployment.
```shell
#!/bin/bash
# Set the name of the deployment

DEPLOYMENT_NAME=${DEPLOYMENT_NAME}

# Set the namespace of the deployment

NAMESPACE=${NAMESPACE}

# Set the new CPU and memory limits

NEW_CPU_LIMIT="PLACEHOLDER"

NEW_MEM_LIMIT="PLACEHOLDER"

# Update the deployment with the new limits

kubectl set resources deployment $DEPLOYMENT_NAME -n $NAMESPACE --limits=cpu=$NEW_CPU_LIMIT,memory=$NEW_MEM_LIMIT

```

### Scale up the deployment: If the Kubernetes deployment is experiencing high traffic or load, consider scaling up the deployment to handle the increased demand.
```shell
#!/bin/bash

# Set variables for the Kubernetes deployment

namespace=${NAMESPACE}

deployment=${DEPLOYMENT_NAME}

replicas="PLACEHOLDER"

# Scale up the deployment

kubectl scale deployment -n $namespace $deployment --replicas=$replicas

# Check the status of the deployment

kubectl rollout status deployment -n $namespace $deployment

```