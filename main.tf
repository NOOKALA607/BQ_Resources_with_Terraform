provider "google" {
  project = var.project_id
  region  = var.location
}

module "bigquery_dataset" {
  source                      = "./modules/bq_dataset"
  project_id                  = var.project_id
  dataset_id                  = var.dataset_id
  dataset_name                = var.dataset_name
  location                    = var.location
  friendly_name               = var.friendly_name
  description                 = var.description
  labels                      = var.labels
  default_table_expiration_ms = var.default_table_expiration_ms
  delete_contents_on_destroy  = var.delete_contents_on_destroy
  deletion_protection         = var.deletion_protection
  access_config               = var.access_config
  tables                      = var.tables
  schema_dir                  = var.schema_dir
  time_partitioning           = var.time_partitioning
  views                       = var.views
}
