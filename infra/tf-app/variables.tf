variable "college_id" {
  description = "A prefix to add to resource names"
  type        = string
  default     = "mckennr"
}

variable "assignment_number" {
  description = "Additional prefix to add to resource names"
  type        = string
  default     = "a12"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "westus3"
}