context('limit')

test_that('Limiting functions throw expected errors', {
  counter <- generator(0, function (state) state + 1)
  limited <- limit(counter, ~ state < 4)
  expect_error(take(limited, 4))
  expect_true(is_limited(limited))
})