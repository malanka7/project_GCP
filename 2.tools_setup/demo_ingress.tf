# # Create a namespace for demo ingress

# module "ingress-demo" {
#   source = "../modules/terraform-k8s-namespace/"
#   name   = "ingress-demo"
# } 

# # Deploy a demo ingress

# CMND + /
# module "ingress-demo-deployment" {
#   source               = "../modules/terraform-helm/"
#   deployment_name      = "ingress-demo"
#   deployment_namespace = "ingress-demo"
#   chart                = "ingress-nginx"
#   repository           = "https://kubernetes.github.io/ingress-nginx"
#   chart_version        = "4.7.0"
#   values_yaml          = <<-EOF

# commonLabels: {}
#   team: devops
#   billing: q1

# controller:
#   annotations: 
#     team: devops
#     billing: q1

#     labels: {}
#       keel.sh/policy: patch
#       keel.sh/trigger: poll 

#     resources:
#         limits:
#           cpu: 1024m
#           memory: 900Mi
#         requests:
#           cpu: 100m
#           memory: 90Mi  
#     service:
#       enabled: true
#       loadBalancerSourceRanges: [
#         "10.0.0.0/16",
#         "10.3.249.155",  # Employee 1
#         "10.3.243.201",  # Employee 2

  
#   EOF
# }

