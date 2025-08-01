resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.dataset_id
  project                     = var.project_id
  location                    = var.location
  friendly_name               = var.friendly_name
  description                 = var.description
  default_table_expiration_ms = var.default_table_expiration_ms != null ? var.default_table_expiration_ms : null
  delete_contents_on_destroy  = var.delete_contents_on_destroy
  labels                      = var.labels
}

resource "google_bigquery_dataset_access" "access" {
  for_each = var.access_config

  dataset_id = google_bigquery_dataset.dataset.dataset_id
  project    = var.project_id
  role       = each.value.role

  # Optional fields — only one should be set ideally
  user_by_email    = lookup(each.value, "user_by_email", null)
  group_by_email   = lookup(each.value, "group_by_email", null)
  domain           = lookup(each.value, "domain", null)
  special_group    = lookup(each.value, "special_group", null)

  dynamic "view" {
    for_each = each.value.view != null ? [each.value.view] : []
    content {
      project_id = view.value.project_id
      dataset_id = view.value.dataset_id
      table_id   = view.value.table_id
    }
  }
}

resource "google_bigquery_table" "tables" {
  for_each = var.tables

  dataset_id  = var.dataset_id
  table_id    = each.value.table_id
  project     = var.project_id
  schema      = file("${var.schema_dir}/${each.value.schema_file}")
  deletion_protection = false
  labels             = lookup(each.value, "labels", {})

  depends_on = [google_bigquery_dataset.dataset]

  dynamic "time_partitioning" {
    for_each = lookup(each.value, "time_partitioning", null) != null ? [1] : []
    content {
      type         = each.value.time_partitioning.type
      field        = lookup(each.value.time_partitioning, "field", null)
      expiration_ms = lookup(each.value.time_partitioning, "expiration_ms", null)
    }
  }

  clustering = lookup(each.value, "clustering", null)
}
