context('accessors')

test_that('Accessors return expected attributes on creation', {
  counter <- generator(0, function (state) state + 1)

  expect_is(counter, 'generator')
  expect_is(get_update(counter), 'function')
  expect_is(get_wrapper(counter), 'function')
  expect_false(is_limited(counter))
  expect_false(is_exhausted(counter))

  # Initial state
  expect_equal(get_start(counter), 0)
  expect_equal(get_state(counter), 0)
  expect_equal(get_series(counter), 0)

  # First iteration
  counter()
  expect_equal(get_state(counter), 1)
  expect_equal(get_series(counter), 1)
})