variable "frontend_admins" {
  description = "List of frontend admin ids"
  type        = list(number)
  default     = [71, 63]
}

variable "frontend_devs" {
  description = "List of frontend dev ids"
  type        = list(number)
  default     = [82, 102, 182]
}

variable "backend_admins" {
  description = "List of backend admin ids"
  type        = list(number)
  default     = [713]
}

variable "backend_devs" {
  description = "List of backend dev ids"
  type        = list(number)
  default     = [767, 90, 152]
}
