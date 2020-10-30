#' Print S1 Bucket Information
#'
#' @importFrom purrr map
#' @importFrom dplyr bind_rows
#' @importFrom lubridate ymd_hms
#' @param key_access Your AWS ACCESS Key.
#' @param key_secret Your AWS SECRET Key.
#' @param region Your AWS REGION.
#'
#' @return A tibble
#' @export s3_list_buckets
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
#'
s3_list_buckets <- function(key_access = Sys.getenv("AWS_ACCESS"),
                            key_secret = Sys.getenv("AWS_SECRET"),
                            region = Sys.getenv("AWS_REGION")) {
  ec2_client <- client(
    service = "s3",
    key_access = key_access,
    key_secret = key_secret,
    region = region
  )

  b_list_buckets <- ec2_client$list_buckets()

  bucket_list <- map(b_list_buckets$Buckets, function(x) {
    tibble(
      name = x$Name,
      creation_date = ymd_hms(as.character(x$CreationDate))
    )
  })

  bind_rows(bucket_list)
}
