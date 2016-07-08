context('generator')

test_that('Constant generator returns expected values', {
  constant <- generator(1, ~ identity(state))

  expect_equal(constant(), 1)
  expect_equal(constant(), 1)
  expect_equal(constant(), 1)
})

test_that('Count generator returns expected values', {
  counter <- generator(0, function (state) state + 1)

  expect_equal(counter(), 1)
  expect_equal(counter(), 2)
  expect_equal(counter(), 3)
})

test_that('Fibonacci generator returns expected values', {
  fib <- generator(c(0, 1),
                   ~ c(state[2], sum(state)),
                   ~ state[1])

  expect_equal(fib(), 1)
  expect_equal(fib(), 1)
  expect_equal(fib(), 2)
  expect_equal(fib(), 3)
})