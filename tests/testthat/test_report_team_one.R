context("test_team_one")

data(team_one(system.file("shape/nc.shp", package="sf"),
              tolerance = 0.1))
test_that("system file is properly formatted", {
  expect_s3_class(team_one(system.file("shape/nc.shp", package="sf"),
                           tolerance = 0.1)[[1]], "data.frame")


})


