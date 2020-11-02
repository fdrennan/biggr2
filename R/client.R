#' Gain Access to the boto3 Module
#' @title boto
#' @family Python Module
#'
#' @importFrom reticulate import
#'
#' @export client
#'
#' @description `boto3()` is equivalent to `import boto3` in Python
#'
#' @details This is the base function that the entire `biggr2` package
#' runs off of. This is a wrapper for `reticulate::import('boto3')`
#'
#' @return
#' A reticulate module
#'
#' @examples
#' \dontrun{
#' boto <- boto3()
#' }
#' @export boto3
boto3 <- function() {
  import("boto3")
}

#' Access an AWS Client Service
#' @title client
#' @family client
#' @description Client Level Access to AWS Services:w
#'
#' @param service NULL Ane AWS Service like `'ec2'` or `'s3'`
#' @param key_access NULL Your AWS ACCESS Key
#' @param key_secret NULL Your AWS Secret Key
#' @param region NULL Your preferred AWS Region, mine is us-east-2
#'
#' @importFrom reticulate import
#' @export client
client <- function(service = NULL, key_access = NULL, key_secret = NULL, region = NULL) {
  client <- boto3()$client

  client(
    service,
    aws_access_key_id = key_access,
    aws_secret_access_key = key_secret,
    region_name = region
  )
}
