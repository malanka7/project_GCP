terraform {
  backend "gcs" {
    bucket = "terraform-project-vera"
    prefix = "/dev/mnt/malanka7/project_infrastructure/1.cluster_setup"
  }
}
