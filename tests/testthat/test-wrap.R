context('wrap')

test_that('Wrapping alters series output', {
  counter <- generator(0, ~ state + 1)
  squares <- function(x) x^2
  seq <- 1:5
  wrapped <- wrap(counter, squares)
  expect_equal(take(wrapped, 5), seq ^ 2)

  fib <- generator(c(0, 1),
                   ~ c(state[2], sum(state)),
                   ~ state[1])

  fibw <- wrap(fib, squares)
  expect_equal(take(fibw, 5), c(1, 1, 4, 9, 25))
})