test_that("boto3 imports as expected", {
  testthat::expect_equal(
    class(biggr2::boto3()),
    c("python.builtin.module", "python.builtin.object")
  )
})
