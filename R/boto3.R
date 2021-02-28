#' Gain Access to the boto3 Module
#' @title boto
#'
#' @family python
#'
#' @importFrom reticulate import
#'
#' @export client
#'
#' @description `boto3()` is equivalent to `import boto3` in Python
#'
#' These are the latest documents:
#'
#' +  [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)
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
