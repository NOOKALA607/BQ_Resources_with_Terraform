# template = {
#     repo    = "workstream-data--template"
#     path    = "Schemas"
#     version = "v14.47.3"
# }

# labels = {
#     environment = "dev"
#     owner       = "manohar"
#     team        = "data-engineering"
# }

project_id = "regal-throne-467709-i2"
location = "us-central1"
dataset_id = "Employee_Data"
dataset_name = "Employee_Data"
friendly_name = "Employee_Data"

description = "Employee_Data"
default_table_expiration_ms = null
delete_contents_on_destroy = true
deletion_protection = false

# Schema Directory
schema_dir = "Schemas"


access_config = {
    "bqdataadmin" = {
        role = "roles/bigquery.admin"
        user_by_email ="sathrobots123@gmail.com"
    },

    "bqdataeditor" = {
        role = "roles/bigquery.dataEditor"
        user_by_email ="manoharnookala123@gmail.com"
    }

}


tables = {
  "Employee_Attendance" = {
    table_id      = "Employee_Attendance"
    schema_file   = "attendance.json"
    project_id    = "regal-throne-467709-i2"
    location      = "us-central1"
    clustering    = ["employee_id"]
  }

  "Employee_Details" = {
    table_id      = "Employee_Details"
    schema_file   = "employees_details.json"
    project_id    = "regal-throne-467709-i2"
    location      = "us-central1"
    clustering    = ["employee_id"]
  }
}


time_partitioning = {
    Employee_Attendance = {
        type = "DAY",
        field = "Date_of_Attendance",
        require_partition_filter = false
    },
    Employee_Details = {
        type = "DAY",
        field = "Joined_Date",
        require_partition_filter = false
    }
}

# Views you can update in future
views = {}





