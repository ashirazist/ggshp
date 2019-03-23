context("test-team_7test")

test_that("errors happen", {

  expect_error(team_7fun(system.file("shape/nc.shp", package="sf"), mytoler="A"),"Assertion on 'mytoler' failed: Must be of type 'number', not 'character'.")

  expect_error(team_7fun(system.file("shape/nc.shp", package="sf"), mytoler =-7),"Assertion on 'mytoler' failed: Element 0 is not >= 0.")

})
