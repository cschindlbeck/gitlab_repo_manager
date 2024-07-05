resource "gitlab_project" "gitlab_repo_manager" {
  name         = "gitlab_repo_manager"
  description  = "Gitlab project you want to set merge_method for"
  namespace_id = 693
  merge_method = "ff"
}
