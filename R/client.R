#' paramiko
#' @export paramiko
paramiko <- function() {
  import("paramiko")
}

#' Access an AWS Client Service
#' @title client
#' @family client
#' @description Client Level Access to AWS Services
#'
#' @param service NULL An AWS Service like 'ec2' or 's3'
#' @param key_access NULL Your AWS ACCESS Key
#' @param key_secret NULL Your AWS Secret Key
#' @param region NULL Your preferred AWS Region, mine is us-east-2
#'
#' @importFrom reticulate import
#' @export client
client <- function(service = NULL,
                   key_access = Sys.getenv("AWS_ACCESS"),
                   key_secret = Sys.getenv("AWS_SECRET"),
                   region = Sys.getenv("AWS_REGION")) {
  client <- boto3()$client

  client <- client(
    service,
    aws_access_key_id = key_access,
    aws_secret_access_key = key_secret,
    region_name = region
  )
}

#' boto
#' @export boto3
boto3 <- function() {
  import("boto3")
}
