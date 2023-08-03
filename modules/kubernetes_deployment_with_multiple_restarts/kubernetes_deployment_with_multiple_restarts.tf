resource "shoreline_notebook" "kubernetes_deployment_with_multiple_restarts" {
  name       = "kubernetes_deployment_with_multiple_restarts"
  data       = file("${path.module}/data/kubernetes_deployment_with_multiple_restarts.json")
  depends_on = [shoreline_action.invoke_update_deployment_limits,shoreline_action.invoke_scale_deployment]
}

resource "shoreline_file" "update_deployment_limits" {
  name             = "update_deployment_limits"
  input_file       = "${path.module}/data/update_deployment_limits.sh"
  md5              = filemd5("${path.module}/data/update_deployment_limits.sh")
  description      = "Increase resource allocation: If the root cause is identified as insufficient resources, increase the allocation of CPU, memory, or other resources to the Kubernetes deployment."
  destination_path = "/agent/scripts/update_deployment_limits.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "scale_deployment" {
  name             = "scale_deployment"
  input_file       = "${path.module}/data/scale_deployment.sh"
  md5              = filemd5("${path.module}/data/scale_deployment.sh")
  description      = "Scale up the deployment: If the Kubernetes deployment is experiencing high traffic or load, consider scaling up the deployment to handle the increased demand."
  destination_path = "/agent/scripts/scale_deployment.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_deployment_limits" {
  name        = "invoke_update_deployment_limits"
  description = "Increase resource allocation: If the root cause is identified as insufficient resources, increase the allocation of CPU, memory, or other resources to the Kubernetes deployment."
  command     = "`chmod +x /agent/scripts/update_deployment_limits.sh && /agent/scripts/update_deployment_limits.sh`"
  params      = ["DEPLOYMENT_NAME","NAMESPACE"]
  file_deps   = ["update_deployment_limits"]
  enabled     = true
  depends_on  = [shoreline_file.update_deployment_limits]
}

resource "shoreline_action" "invoke_scale_deployment" {
  name        = "invoke_scale_deployment"
  description = "Scale up the deployment: If the Kubernetes deployment is experiencing high traffic or load, consider scaling up the deployment to handle the increased demand."
  command     = "`chmod +x /agent/scripts/scale_deployment.sh && /agent/scripts/scale_deployment.sh`"
  params      = ["DEPLOYMENT_NAME","NAMESPACE"]
  file_deps   = ["scale_deployment"]
  enabled     = true
  depends_on  = [shoreline_file.scale_deployment]
}

