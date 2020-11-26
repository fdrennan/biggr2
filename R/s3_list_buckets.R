#' s3_list_buckets
#'
#' @param client A connection to a boto3, S3 Client
#' @importFrom purrr map
#' @importFrom dplyr as_tibble
#' @return A tibble 
#' @export s3_list_buckets
#' 
#' @family s3
#' @family descriptions
#' 
#' @description 
#' 
#' `s3_list_buckets` returns a data frame of bucket names and their creation date
#' 
#' [s3-example-creating-buckets](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3-example-creating-buckets.html)
#'
#' @examples
#' \dontrun{
#' library(biggr2)
#' 
#' s3_client <- 
#'   client(
#'     service = "s3",
#'     key_access = Sys.getenv("AWS_ACCESS"),
#'     key_secret = Sys.getenv("AWS_SECRET"),
#'     region = "us-east-2"
#'  )
#' 
#' s3_list_buckets(client = s3_client)
#'}
s3_list_buckets <- function(client = NULL) {
  
  list_buckets <- client$list_buckets()$Buckets
  bucket_response <- map(list_buckets, function(x) {
    data.frame(
      name = x$Name,
      creation_date = as.Date(x$CreationDate$date())
    )
  })
  bucket_response <- do.call(rbind, bucket_response)
  as_tibble(bucket_response)
}
