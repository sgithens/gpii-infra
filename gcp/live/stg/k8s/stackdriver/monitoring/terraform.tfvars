# ↓ Module metadata
terragrunt = {
  terraform {
    source = "/project/modules//gcp-stackdriver-monitoring"
  }

  dependencies {
    paths = [
      "../../gpii/preferences",
      "../../gpii/flowmanager",
      "../../gpii/devpmt",
      "../lbm",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

notification_email = "alerts+stg@raisingthefloor.org"
