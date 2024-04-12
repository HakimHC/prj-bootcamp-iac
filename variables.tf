variable "repo_name" {
  type        = string
  description = "Name of the github repository configured in Cloud Build."
}

variable "github_owner" {
  type        = string
  description = "Owner of the github repository."
}

variable "cloud_build_yaml_path" {
  type        = string
  description = "Path to cloudbuild.yaml file in the configured repo"
}

variable "region" {
  type        = string
  description = "GCP region."
}

variable "project" {
  type        = string
  description = "GCP project."
}

variable "slack_api_token" {
  type        = string
  description = "Slack API auth token."
}

# ========= SIMPLY STATIC VARS ==========

variable "ssp_github_token" {
  type        = string
  description = "Github token for SSP."
}

variable "ssp_github_user" {
  type        = string
  description = "Github user for SSP."
}

variable "ssp_github_repo" {
  type        = string
  description = "Github repo for SSP."
}

variable "ssp_github_branch" {
  type        = string
  description = "Github repo branch for SSP."
  default = "main"
}
