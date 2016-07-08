context('filter')

test_that('Keep retains desired values', {
  counter <- generator(0, ~ state + 1)
  kept <- keep(counter, ~ state %% 2 == 0)
  expect_equal(kept(), 2)
  expect_equal(kept(), 4)
  expect_equal(kept(), 6)

  # Even more values
  more <- take(kept, 10)
  expect_true(all(more %% 2 == 0))
})

test_that('Discard removes desired values', {
  counter <- generator(0, ~ state + 1)
  discarded <- discard(counter, ~ state %% 2 == 0)
  expect_equal(discarded(), 1)
  expect_equal(discarded(), 3)
  expect_equal(discarded(), 5)

  # Even more values
  more <- take(discarded, 10)
  expect_false(any(more %% 2 == 0))
})