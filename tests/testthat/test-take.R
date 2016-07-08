context('take')

test_that('Take returns expected lengths and values', {
  counter <- generator(0, ~ state + 1)
  expect_equal(take(counter, 5), seq_len(5))

  fib <- generator(c(0, 1),
                   ~ c(state[2], sum(state)),
                   ~ state[1])

  expect_equal(length(take(fib, 5)), 5)
})