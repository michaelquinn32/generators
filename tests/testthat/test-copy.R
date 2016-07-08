context('copy')

test_that('Copy returns a new generator', {
  counter1 <- generator(0, ~ state + 1)
  counter2 <- copy(counter1)

  expect_equal(counter1(), counter2())
  expect_false(identical(counter1, counter2))
})