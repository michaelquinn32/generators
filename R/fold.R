#' Fold a generator N times with a binary function
#'
#' \code{foldn} is the generator-equivalent of the function \code{\link{Reduce}}.
#' It takes a generator, produces \code{.n} values and applies a binary
#' function iteratively, returning a scalar.
#'
#' @param .generator A function with the class \code{generator}
#' @param .n The number of iterations to produce
#' @param .FUN A binary fold function to reduce the generator to a single value
#' @param ... Additional arguments to .FUN
#' @param .start The starting value for the reduction
#'
#' @examples
#' # Sum from 1 to 10
#' counter <- generator(0, function (state) state + 1)
#' counter %>% copy %>% foldn(10, `+`)
#'
#' @export

foldn <- function(.generator, .n, .FUN, ..., .start = 0) UseMethod('foldn')


#' @export

foldn.generator <- function(.generator, .n, .FUN, ..., .start = 0) {
  f <- as_function(.FUN, ...)
  n <- 0
  out <- .start

  while (n < .n) {
    n <- n + 1
    out <- f(out, .generator(), ...)
  }

  out
}

#' Consume a fold a generator, producing a scalar
#'
#' Generate iterations of a generator up to its limit, reducing the values
#' using a binary function.
#'
#' @param .generator A function with the class \code{generator}
#' @param .FUN A binary fold function to reduce the generator to a single value
#' @param ... Additional arguments to .FUN
#' @param .start The starting value for the reduction
#'
#' @seealso
#' \code{\link{foldn}} and \code{\link{consume}}
#'
#' @examples
#' # Sum of numbers from 1 to 10
#' counter <- generator(0, function (state) state + 1)
#'
#' counter %>%
#'   limit(~ state <= 10) %>%
#'   foldc(`+`)
#'
#' # Version of Project Euler 2: Sum of even Fibonacci numbers
#' fib <- generator(c(0, 1),
#'                  ~ c(state[2], sum(state)),
#'                  ~ state[1])
#'
#' fib %>%
#'   keep(~ state %% 2 == 0) %>%
#'   limit(~ state < 400) %>%
#'   foldc(`+`)
#'
#' @export

foldc <- function(.generator, .FUN, ..., .start = 0) UseMethod('foldc')


#' @export

foldc.generator <- function(.generator, .FUN, ..., .start = 0) {
  if (is_limited(.generator)) {
    f <- as_function(.FUN, ...)
    wrapped <- wrap(.generator, function(state) {
      tryCatch(state, error = function(e) NULL)
    })

    out <- .start
    val <- wrapped()
    while (!is.null(val)) {
      out <- f(out, val, ...)
      val <- wrapped()
    }

    out

  } else stop('A generator must have a limit to consume', call. = FALSE)
}