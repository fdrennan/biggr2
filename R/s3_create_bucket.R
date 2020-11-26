
#' s3_create_bucket
#'
#' @description
#'
#' [S3.Client.create_bucket](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html#S3.Client.create_bucket)
#'
#'
#' ```
#' response = client.create_bucket(
#'   ACL='private'|'public-read'|'public-read-write'|'authenticated-read',
#'   Bucket='string',
#'   CreateBucketConfiguration={
#'     'LocationConstraint': 'af-south-1'|'ap-east-1'|'ap-northeast-1'|'ap-northeast-2'|'ap-northeast-3'|'ap-south-1'|'ap-southeast-1'|'ap-southeast-2'|'ca-central-1'|'cn-north-1'|'cn-northwest-1'|'EU'|'eu-central-1'|'eu-north-1'|'eu-south-1'|'eu-west-1'|'eu-west-2'|'eu-west-3'|'me-south-1'|'sa-east-1'|'us-east-2'|'us-gov-east-1'|'us-gov-west-1'|'us-west-1'|'us-west-2'
#'   },
#'   GrantFullControl='string',
#'   GrantRead='string',
#'   GrantReadACP='string',
#'   GrantWrite='string',
#'   GrantWriteACP='string',
#'   ObjectLockEnabledForBucket=True|False
#' )
#' ```
#' @param Bucket A name for the bucket
#' @param LocationConstraint An AWS region. Defaults to us-east-2'
#' @param ... Additional Parameters to `client$create_bucket`
#' 
#' @family s3
#' @family creation
#' 
#' @export s3_create_bucket
s3_create_bucket <- function(client = NULL, Bucket = NA, LocationConstraint = "us-east-2", ...) {
  response <-
    client$create_bucket(
      Bucket = Bucket,
      CreateBucketConfiguration = list(LocationConstraint = LocationConstraint),
      ...
    )

  data.frame(
    Location = response$Location,
    RequestId = response$ResponseMetadata$RequestId,
    HostId = response$ResponseMetadata$HostId,
    HTTPStatusCode = response$ResponseMetadata$HTTPStatusCode,
    HTTPHeaders = response$ResponseMetadata$HTTPHeaders
  )
}
