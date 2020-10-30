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

#' @title client
#' @family client
#' @description Client Level Access to AWS Services:w
#'
#' @param service
#' @importFrom reticulate import
#' @export client
client <- function(service = NULL, key_access = NULL, key_secret = NULL, region = NULL) {
  client <- boto3()$client(
    service,
    aws_access_key_id = key_access,
    aws_secret_access_key = key_secret,
    region_name = region
  )
}
