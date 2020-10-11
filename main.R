library(botor)
library(tidyverse)
library(biggr2)

reticulate::conda_install(packages = 'boto3')
# botor::botor_client('s3')
#

configure_aws(
  aws_access_key_id = Sys.getenv("AWS_ACCESS"),
  aws_secret_access_key = Sys.getenv("AWS_SECRET"),
  default.region = Sys.getenv("AWS_REGION")
)

BUCKET_NAME = 'scratchfdrennan'
s3_list_buckets()

s3_delete_bucket(bucket_name = BUCKET_NAME)
s3_create_bucket(bucket_name = BUCKET_NAME)
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
s3_delete_bucket(bucket_name = BUCKET_NAME)
