module "jenkins-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "jenkins"
}



module "jenkins-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "jenkins"
  deployment_namespace = module.jenkins-terraform-k8s-namespace.namespace
  chart                = "jenkins"
  chart_version        = var.jenkins-config["chart_version"]
  repository           = "https://charts.jenkins.io"
  values_yaml          = <<EOF
controller:
  ingress:
    enabled: yes
    apiVersion: networking.k8s.io/v1
    annotations:
      ingress.kubernetes.io/ssl-redirect: "false"
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod-dns01
      acme.cert-manager.io/http01-edit-in-place: "true"
    hostName: "jenkins.${var.google_domain_name}"
    tls:
      - secretName: jenkins
        hosts:
          - "jenkins.${var.google_domain_name}"
  adminUser: admin
  adminPassword: password
persistence:
  type: pvc
  enabled: true
adminUser: admin
adminPassword: password
datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
    - name: jenkins
      type: jenkins
      url: http://jenkins-server.jenkins.svc.cluster.local:8080
      access: proxy
      isDefault: true
    
  EOF
}



