# Please get your AWS Domain
google_domain_name = "verakarmash.com"

# Use GCP account email
email              = "karmashvera7@gmail.com"

# Add bucketname you created above
BUCKET_NAME        = "terraform-project-vera"

# Add project name you created above
PROJECT_ID         = "terraform-project-vera"   # Keep in mind, ID not the name


datadog-config = {
  deployment_name = "datadog"
  apiKey          = "866c3dc14f2a225812284e955f49030b"
  site            = "us5.datadoghq.com"
  cpu_requests    = "200m"
  memory_requests = "256Mi"
  cpu_limits      = "500m"
  memory_limits   = "1024Mi"
}