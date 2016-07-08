context('skip')

test_that('Skip updates correctly', {
  counter <- generator(0, ~ state + 1)
  expect_equal(counter(), 1)
  skip(counter, 1)
  expect_equal(counter(), 3)
})