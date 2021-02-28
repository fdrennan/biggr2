
<!-- README.md is generated from README.Rmd. Please edit that file -->

# biggr2

<!-- badges: start -->

[![CircleCI build
status](https://circleci.com/gh/fdrennan/biggr2.svg?style=svg)](https://circleci.com/gh/fdrennan/biggr2)

[![codecov](https://codecov.io/gh/fdrennan/biggr2/branch/main/graph/badge.svg?token=bql3Sg35ae)](undefined)

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

<!-- badges: end -->

![](https://codecov.io/gh/fdrennan/biggr2/commit/cffdd2c603842d321bcc29b00a78d4e1f732cfa1/graphs/sunburst.svg)

[Code Coverage](https://codecov.io/gh/fdrennan/biggr2)

Download the development version from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("fdrennan/biggr2")
```

## Getting Started

#### `s3` storage

``` r
library(biggr2)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

test_bucket_name <- 'fdrenabc'

s3_client <- 
  client(
    service = "s3",
    key_access = Sys.getenv("AWS_ACCESS"),
    key_secret = Sys.getenv("AWS_SECRET"),
    region = "us-east-2"
 )
```

``` r
current_buckets <- s3_list_buckets(client = s3_client)

if (test_bucket_name %in% pull(current_buckets, name)) 
  s3_delete_bucket(client = s3_client, test_bucket_name)
#> # A tibble: 1 x 4
#>   RequestId    HostId                         HTTPStatusCode TimeDeleted        
#>   <chr>        <chr>                                   <int> <dttm>             
#> 1 79CD84F23CB… L7jLaOpbVZgmPVCU1yOdrgRVWR9w5…            204 2020-11-26 23:20:24

response <- s3_create_bucket(
  client = s3_client, 
  Bucket = 'fdrenabc'
)

response
#>                            Location        RequestId
#> 1 http://fdrenabc.s3.amazonaws.com/ 89608CA3D3C9D0F2
#>                                                                         HostId
#> 1 s1inZXUa51DJV/Sz+Rt8MXZLsUVdaRWVjjoz/zZPnWWHYS4/bfUk+BREw4h3RjX9fTGhRiNprEs=
#>   HTTPStatusCode
#> 1            200
#>                                                         HTTPHeaders.x.amz.id.2
#> 1 s1inZXUa51DJV/Sz+Rt8MXZLsUVdaRWVjjoz/zZPnWWHYS4/bfUk+BREw4h3RjX9fTGhRiNprEs=
#>   HTTPHeaders.x.amz.request.id              HTTPHeaders.date
#> 1             89608CA3D3C9D0F2 Thu, 26 Nov 2020 23:20:27 GMT
#>                HTTPHeaders.location HTTPHeaders.content.length
#> 1 http://fdrenabc.s3.amazonaws.com/                          0
#>   HTTPHeaders.server
#> 1           AmazonS3
```
