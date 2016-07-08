#' Modify a generators wrapping function, spawning a new generator
#'
#' Wrapping is the standard technique for spawning new generators. By default
#' all generators are wrapped in the \code{identity} function. When applying
#' \code{wrap}, we take the value currently returned by the generator and
#' use it as the argument in another function. To be safe, the function spawns
#' a new generator. Updating the second generator does not affect the first.
#'
#' Wrapping is also the engine for a variety of other standard modifications
#' to generators, including filtering.
#'
#' @param .generator A function with the class \code{generator}
#' @param .wrap A function that takes \code{state} as an argument
#'
#' @examples
#' # Create a counter than returns the square values of the natural numbers
#' counter <- generator(0, function (state) state + 1)
#' squares <- function(state) state ^ 2
#' squared <- counter %>% wrap(squares)
#' squared %>% take(5)
#'
#' @export

wrap <- function(.generator, .wrap) UseMethod('wrap')


#' @export

wrap.generator <- function(.generator, .wrap) {
  f <- as_function(.wrap)
  g <- get_wrapper(.generator)
  wrapper <-  function(state) f(g(state))
  gen <- generator(get_state(.generator), get_update(.generator), wrapper)
  copy_attrs(.generator, gen)
}
