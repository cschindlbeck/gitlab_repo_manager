terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "17.1.0"
    }
  }
}

variable "gitlab_token" {}

provider "gitlab" {
  base_url = "https://gitlab.iav.com/api/v4"
  token    = var.gitlab_token
}

# Specify the path to your group
data "gitlab_group" "group" {
  full_path = "Ernteroboter/Libraries/ROS"
}

# Filter repositories for the frontend
data "gitlab_projects" "frontend_projects" {
  group_id          = data.gitlab_group.group.id
  order_by          = "name"
  include_subgroups = true
  search            = "frontend" # filter out repos containing 'frontend'
}

# Filter repositories for the backend
data "gitlab_projects" "backend_projects" {
  group_id          = data.gitlab_group.group.id
  order_by          = "name"
  include_subgroups = true
  search            = "backend" # filter out repos containing 'backend'
}
