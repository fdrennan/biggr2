library(biggr2)

configure_aws(
  aws_access_key_id = Sys.getenv("AWS_ACCESS"),
  aws_secret_access_key = Sys.getenv("AWS_SECRET"),
  default.region = 'us-east-2'
)

reticulate::virtualenv_install(packages = 'boto3')

BUCKET_NAME = 'scratchfdrennan'

#' s3_bucket_exists
#' @param bucket_name A possible bucket name you may own
#' @export s3_bucket_exists
s3_bucket_exists <- function(bucket_name = NULL, verbose = TRUE) {
  existing_buckets <- s3_list_buckets() 
  if (verbose) cli::cli_alert_info('These are your buckets');  print(existing_buckets)
  bucket_name %in% existing_buckets$name
}

#' s3_list_files
#' @param file_name
#' @export s3_file_exists
s3_file_exists <- function(bucket_name = NULL, file_name = NULL) {
  objects <- s3_list_objects(bucket_name = bucket_name)
  print(head(objects))
  file_name %in% objects$key
}

if (magrittr::not(s3_bucket_exists(BUCKET_NAME))) {
  s3_create_bucket(BUCKET_NAME)
} else {
  objects <- s3_list_objects(bucket_name = BUCKET_NAME)
  purrr::walk(
    objects$key, ~ s3_delete_file(bucket = BUCKET_NAME, file = .)
  )
  s3_delete_bucket(bucket_name = BUCKET_NAME)
  s3_create_bucket(BUCKET_NAME)
}



fs::file_create('text.txt')

s3_upload_file(
  bucket = 'scratchfdrennan',
  from = 'text.txt',
  to = 'text_there.txt',
  make_public = FALSE
)

s3_download_file(
  bucket = 'scratchfdrennan',
  from = 'text_there.txt',
  to = 'text_here.txt'
)

