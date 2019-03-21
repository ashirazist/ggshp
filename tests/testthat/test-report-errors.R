context("test-report-errors")

test_that("errors are not reported properly", {
  expect_error(team_11(system.file("shape/nc.shp", package="sf"), tol="A"),"tol is not numeric")
  expect_error(team_11(system.file("shape/nc.shp", package="sf"), tol=c(1:3)),"tol is not one number")
})
