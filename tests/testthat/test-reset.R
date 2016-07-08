context('reset')

test_that('Reset returns state to start', {
  counter <- generator(0, ~ state + 1)
  discard <- take(counter, 5)
  reset(counter)
  expect_equal(get_state(counter), get_start(counter))
})