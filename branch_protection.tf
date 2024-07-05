# # Protect your master branch
resource "gitlab_branch_protection" "frontend_master_protection" {
  for_each                     = { for project in data.gitlab_projects.frontend_projects.projects : project.id => project }
  project                      = each.value.id
  allow_force_push             = true
  code_owner_approval_required = true
  branch                       = "master"
  push_access_level            = "no one" # do not push to master directly
  merge_access_level           = "no one" # we will specify who can push below
  dynamic "allowed_to_merge" {
    for_each = var.frontend_admins
    content {
      user_id = allowed_to_merge.value
    }
  }
}

resource "gitlab_branch_protection" "frontend_dev_protection" {
  for_each                     = { for project in data.gitlab_projects.frontend_projects.projects : project.id => project }
  project                      = each.value.id
  allow_force_push             = false
  code_owner_approval_required = true
  branch                       = "dev"
  push_access_level            = "developer" # here, let's allow every developer to push, regardless of front- or backend
  merge_access_level           = "no one"    # we will specify who can push below
  dynamic "allowed_to_merge" {
    for_each = distinct(concat(var.frontend_admins, var.frontend_devs)) # union over devs and admins
    content {
      user_id = allowed_to_merge.value
    }
  }
  dynamic "allowed_to_push" {
    for_each = distinct(concat(var.frontend_admins, var.frontend_devs)) # union over devs and admins
    content {
      user_id = allowed_to_push.value
    }
  }
}

resource "gitlab_branch_protection" "backend_master_protection" {
  for_each                     = { for project in data.gitlab_projects.backend_projects.projects : project.id => project }
  project                      = each.value.id
  allow_force_push             = true
  code_owner_approval_required = true
  branch                       = "master"
  push_access_level            = "no one" # do not push to master directly
  merge_access_level           = "no one" # we will specify who can push below
  dynamic "allowed_to_merge" {
    for_each = var.backend_admins
    content {
      user_id = allowed_to_merge.value
    }
  }
}

resource "gitlab_branch_protection" "backend_dev_protection" {
  for_each                     = { for project in data.gitlab_projects.backend_projects.projects : project.id => project }
  project                      = each.value.id
  allow_force_push             = false
  code_owner_approval_required = false
  branch                       = "dev"
  push_access_level            = "no one"
  merge_access_level           = "no one" # change to maintainer, developer if needed
  dynamic "allowed_to_merge" {
    for_each = distinct(concat(var.backend_admins, var.backend_devs)) # union over devs and admins
    content {
      user_id = allowed_to_merge.value
    }
  }
  dynamic "allowed_to_push" {
    for_each = distinct(concat(var.backend_admins, var.backend_devs)) # union over devs and admins
    content {
      user_id = allowed_to_push.value
    }
  }
}
