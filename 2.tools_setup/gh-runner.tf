module "ghrunner-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "actions-runner-system"
}

resource "kubernetes_secret" "controller-manager" {
  metadata {
    name      = "controller-manager"
    namespace = module.ghrunner-terraform-k8s-namespace.namespace
  }
  data = {
    "github_app_id"              = var.ghrunner-config["github_app_id"],
    "github_app_installation_id" = var.ghrunner-config["github_app_installation_id"],
    "github_app_private_key"     = file("../runner.pem")
  }
  type = "generic"
}

module "ghrunner-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = var.ghrunner-config["deployment_name"]
  deployment_namespace = module.ghrunner-terraform-k8s-namespace.namespace
  chart                = "actions-runner-controller"
  chart_version        = var.ghrunner-config["chart_version"]
  repository           = "https://actions-runner-controller.github.io/actions-runner-controller"
  values_yaml          = <<EOF
syncPeriod: 1m
replicaCount: 1
defaultScaleDownDelay: 10m

authSecret:
  enabled: true
  create: false
  name: "controller-manager"
EOF

}

resource "null_resource" "runner" {
    
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "kubectl apply -f runner.yaml"
  }
}