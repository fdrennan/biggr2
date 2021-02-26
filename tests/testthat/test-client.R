
# AWS_ACCESS = system('echo $AWS_ACCESS')
# AWS_SECRET = system('echo $AWS_SECRET')
# AWS_REGION = system('echo $AWS_REGION')

test_that("boto3 imports as expected", {
  testthat::expect_equal(
    class(biggr2::boto3()),
    c("python.builtin.module", "python.builtin.object")
  )
})
