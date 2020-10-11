#' configure_aws
#'
#' @importFrom reticulate import
#' @param aws_access_key_id IAM access key ID
#' @param aws_secret_access_key IAM secret access key
#' @param default.region AWS preferred region
#' @export configure_aws
configure_aws <- function(aws_access_key_id = NA,
                          aws_secret_access_key = NA,
                          default.region = NA) {

  subprocess <- reticulate::import('subprocess')

  access_key <-
    paste("aws configure set aws_access_key_id", aws_access_key_id)

  aws_secret_access_key <-
    paste("aws configure set aws_secret_access_key", aws_secret_access_key)

  default_region <-
    paste("aws configure set default.region", default.region)

  subprocess$call(access_key, shell=TRUE)
  subprocess$call(aws_secret_access_key, shell=TRUE)
  subprocess$call(default_region, shell=TRUE)


}
