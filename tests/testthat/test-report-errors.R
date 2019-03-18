context("test-report-errors")

test_that("errors are not reported properly", {
  data(aus2rd)
  expect_error(team_11(aus2rd, "0.01"),"tol is not numeric")
})
