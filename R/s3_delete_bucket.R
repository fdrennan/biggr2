#' s3_delete_bucket
#'
#' @description
#'
#' [S3.Client.delete_bucket](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html#S3.Client.delete_bucket)
#'
#' @param client An s3 client connection
#' @param bucket A bucket's name staged for deletion
#'
#' @family s3
#'
#' @return A data frame
#' @export s3_delete_bucket
s3_delete_bucket <- function(client = NULL, bucket = NULL) {
  response <- client$delete_bucket(Bucket = bucket)

  tibble::tibble(
    RequestId = response$ResponseMetadata$RequestId,
    HostId = response$ResponseMetadata$HostId,
    HTTPStatusCode = response$ResponseMetadata$HTTPStatusCode,
    TimeDeleted = lubridate::now(tzone = "UTC")
  )
}
