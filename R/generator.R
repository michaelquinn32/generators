#' Construct a new generator
#'
#' A generator is a function that contains a mutable state. Calls to the
#' function change the state and return a value in a series.
#'
#' Syntax sugar is borrowed from
#' \href{https://github.com/hadley/purrr/}{\code{purrr}}, allowing for
#' the creation of anonymous functions using formulas. Unlike \code{purrr},
#' this package uses \code{state} as the key pronoun for all functions.
#'
#' @param .start A vector that describes the initial state of the generator
#' @param .update A function or formula controlling how the state changes
#' over time
#' @param .yield A function or formula controlling how a series is returned
#' from the state
#'
#' @examples
#' # The simplest form of generator is a counter
#' my_counter <- generator(0, ~ state + 1)
#'
#' # More complicated generators also need a yield.
#' my_fib <- generator(c(0, 1),
#'                     ~ c(state[2], sum(state)),
#'                     ~ state[1])
#' take(my_fib, 5)
#'
#' @export

generator <- function(.start, .update, .yield = identity) {
  state <- .start
  env <- environment()
  update <- as_function(.update)
  yield <- as_function(.yield)

  gen <- function () {
    assign('state', update(state), env)
    yield(get('state', envir = env))
  }

  structure(gen,
            class = 'generator',
            limited = FALSE,
            exhausted = FALSE,
            start = .start)
}