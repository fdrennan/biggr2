#' Print S3 Bucket Information
#'
#' @importFrom purrr map
#' @importFrom dplyr bind_rows
#' @importFrom lubridate ymd_hms
#' @importFrom dplyr tibble
#' @param s3_client A connection to a S3 Client
#'
#' @return A tibble
#'
#' @family describe
#' @family s3
#'
#' @examples
#'
#' \dontrun{
#' # Return Information About Existing S3 Buckets
#' s3_list_buckets(
#'   key_access = Sys.getenv("AWS_ACCESS"),
#'   key_secret = Sys.getenv("AWS_SECRET"),
#'   region = Sys.getenv("AWS_REGION")
#' )
#' }
#' @export s3_list_buckets
s3_list_buckets <- function(s3_client = NULL) {
  b_list_buckets <- s3_client$list_buckets()

  bucket_list <- map(b_list_buckets$Buckets, function(x) {
    tibble(
      name = x$Name,
      creation_date = ymd_hms(as.character(x$CreationDate))
    )
  })

  bind_rows(bucket_list)
}
