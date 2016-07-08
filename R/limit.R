#' Set the limit of an iterator
#'
#' The limit of the generator refers to the output series, not the underlying
#' state. This approach tends to be more intuitive, especially when the state
#' is a vector (like the Fibonacci numbers).
#'
#' When the limiting function returns \code{TRUE}, a generator is considered
#' exhausted. Additional calls to an exhausted generator return an error.
#'
#' @param .generator A function with the class \code{generator}
#' @param .limit A predicate function, returning \code{TRUE} or \code{FALSE}
#'
#' @examples
#' # A typical case
#' counter <- generator(0, function (state) state + 1)
#' limited <- counter %>% limit(~ state < 4)
#' limited %>% take(3)
#'
#' # Returns an error
#' \dontrun{limited()}
#'
#' # Fibonacci numbers
#' fib <- generator(c(0, 1),
#'                  ~ c(state[2], sum(state)),
#'                  ~ state[1])
#' limited <- fib %>% limit(~ state < 5)
#' limited %>% take(4)
#'
#' # Returns an error
#' \dontrun{limited()}
#'
#' @export

limit <- function(.generator, .limit) UseMethod('limit')


#' @export

limit.generator <- function(.generator, .limit) {
  limit <- as_function(.limit)
  structure(wrap(.generator, function(state) {
    if (limit(state)) state
    else stop('Generator exhausted', call. = FALSE)
  }), limited = TRUE)
}

#' Recycle a generator
#'
#' Recycling is limiting with one major change. Instead of throwing an error
#' when the generator is exhuasted, \code{recycle} resets the state of the
#' generator to its starting value.
#'
#' @param .generator A function with the class \code{generator}
#' @param .limit A predicate function, returning \code{TRUE} or \code{FALSE}
#'
#' @examples
#' counter <- generator(0, function (state) state + 1)
#' recycled <- counter %>% recycle(~ state < 4)
#' recycled %>% take(7)
#'
#' @export

recycle <- function(.generator, .limit) UseMethod('recycle')


#' @export

recycle.generator <- function(.generator, .limit) {
  limit <- as_function(.limit)
  wrapper <- environment(.generator)$yield
  new_gen <- copy(.generator)

  rebase(new_gen, function(state) {
    if (limit(wrapper(state))) state
    else get_series(reset(.generator))
  })
}