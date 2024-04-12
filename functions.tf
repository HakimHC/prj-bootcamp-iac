module "notifications_function" {
  source  = "GoogleCloudPlatform/cloud-functions/google"
  version = "~> 0.4"

  function_name     = "notifications-function"
  description       = "TF Managed."
  function_location = var.region
  project_id        = var.project
  runtime           = "python39"
  entrypoint        = "hello_pubsub"
  storage_source = {
    bucket     = google_storage_bucket.functions_source_bucket.name
    object     = google_storage_bucket_object.notifications_src.name
    generation = null
  }

  event_trigger = {
    trigger_region        = var.region
    event_type            = "google.cloud.pubsub.topic.v1.messagePublished"
    service_account_email = google_service_account.notification_account.email
    pubsub_topic          = google_pubsub_topic.deploy_notifications.id
    retry_policy          = "RETRY_POLICY_DO_NOT_RETRY"
    event_filters         = null
  }

  service_config = {
    runtime_env_variables = {
      SLACK_API_TOKEN = var.slack_api_token
    }
    all_traffic_on_latest_revision = true
  }

  docker_repository = "projects/${var.project}/locations/${var.region}/repositories/gcf-artifacts"
}