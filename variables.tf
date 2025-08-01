variable "project_id" {
  description = "The ID of the project in which to create the dataset"
  type        = string
}

variable "dataset_id" {
  description = "The ID of the dataset"
  type        = string
}

variable "location" {
  description = "The location of the dataset"
  type        = string
}

variable "dataset_name" {
  description = "Name of the BigQuery dataset"
  type        = string
}

variable "friendly_name" {
  description = "Friendly name for the dataset"
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the dataset"
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels to apply to the dataset"
  type        = map(string)
  default     = {}
}

variable "default_table_expiration_ms" {
  description = "Default expiration time for tables"
  type        = number
  default     = null
}

variable "delete_contents_on_destroy" {
  description = "Whether to delete contents on destroy"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}

variable "access_config" {
  description = "Access configuration blocks"
  type        = map(object({
    role          = string
    user_by_email = optional(string)
    group_by_email = optional(string)
    domain        = optional(string)
    special_group = optional(string)
    view          = optional(object({
      project_id = string
      dataset_id = string
      table_id   = string
    }))
  }))
  default = {}
}



variable "tables" {
  description = "List of table configurations"
  type        = map(object({
    table_id             = string
    schema_file          = string
    clustering           = optional(list(string))
    labels               = optional(map(string))
  }))
  default = {}
}

variable "schema_dir" {
  description = "Path to the directory containing schema JSON files"
  type        = string
}

variable "time_partitioning" {
  description = "Table-level time partitioning configurations"
  type = map(object({
    type                     = string
    field                    = optional(string)
    expiration_ms            = optional(number)
    require_partition_filter = optional(bool)
  }))
  default = {}
}

variable "views" {
  description = "List of views to be created in the dataset"
  type        = map(object({
    view_id   = string
    query     = string
    use_legacy_sql = bool
  }))
  default = {}
}
