context("test-report-errors")

test_that("errors are not reported properly", {
  data(aus2rd)
  expect_error(team_11(aus2rd, tol="A"),"tol is not numeric")
  expect_error(team_11(aus2rd, tol=c(1:3)),"tol is not one number")
})
