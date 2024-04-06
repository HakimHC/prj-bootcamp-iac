variable "repo_name" {
  type = string
  description = "Name of the github repository configured in Cloud Build."
}

variable "github_owner" {
  type = string
  description = "Owner of the github repository."
}

variable "cloud_build_yaml_path" {
  type = string
  description = "Path to cloudbuild.yaml file in the configured repo"
}