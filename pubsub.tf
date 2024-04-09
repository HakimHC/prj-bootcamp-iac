resource "google_pubsub_topic" "deploy_notifications" {
  name = "clouddeploy-operations"
}
