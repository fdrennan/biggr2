
#' s3_create_bucket
#'
#' @description
#'
#' [S3.Client.create_bucket](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html#S3.Client.create_bucket)
#'
#' ```
#' response = client.create_bucket(
#'   ACL='private'|'public-read'|'public-read-write'|'authenticated-read',
#'   bucket='string',
#'   CreatebucketConfiguration={
#'     'LocationConstraint': 'af-south-1'|'ap-east-1'|'ap-northeast-1'|'ap-northeast-2'|'ap-northeast-3'|'ap-south-1'|'ap-southeast-1'|'ap-southeast-2'|'ca-central-1'|'cn-north-1'|'cn-northwest-1'|'EU'|'eu-central-1'|'eu-north-1'|'eu-south-1'|'eu-west-1'|'eu-west-2'|'eu-west-3'|'me-south-1'|'sa-east-1'|'us-east-2'|'us-gov-east-1'|'us-gov-west-1'|'us-west-1'|'us-west-2'
#'   },
#'   GrantFullControl='string',
#'   GrantRead='string',
#'   GrantReadACP='string',
#'   GrantWrite='string',
#'   GrantWriteACP='string',
#'   ObjectLockEnabledForbucket=True|False
#' )
#' ```
#'
#' @param client A connection to the boto3 module
#' @param bucket A name for the bucket
#' @param location_constraint Specifies the Region where the bucket will be created. If you don't specify a Region, the bucket is created in the US East (N. Virginia) Region (us-east-1).
#' @param ... Additional Parameters to `client$create_bucket`
#'
#' @family s3
#'
#' @export s3_create_bucket
s3_create_bucket <- function(client = NULL, bucket = NA, location_constraint = "us-east-1", ...) {
  response <-
    client$create_bucket(
      Bucket = bucket,
      CreateBucketConfiguration = list(LocationConstraint = location_constraint),
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
