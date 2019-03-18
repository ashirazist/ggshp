context("test-test-dimension")

test_that("convertion failed, columne numbers does not match", {
  expect_equal(ncol(team_11(system.file("shape/nc.shp", package="sf"),0.1)),19)
})
