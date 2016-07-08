context('fold')

test_that("Foldn results in appropriate output", {
  counter <- generator(0, ~ state + 1)
  expect_equal(foldn(counter, 10, `+`), 55)
  expect_equal(length(foldn(counter, 10, `+`)), 1)
})