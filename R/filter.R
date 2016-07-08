#' Filter a series by keeping results that fulfill a predicate
#'
#' @param .generator A function with the class \code{generator}
#' @param .keep A predicate function, returning \code{TRUE} or \code{FALSE}
#'
#' @examples
#' # Generate even numbers
#' counter <- generator(0, ~ state + 1)
#' counter %>%
#'   keep(~ state %% 3 == 0) %>% take(5)
#'
#' # Combine a wrap and a counter
#' squares <- function(state) state ^ 2
#' counter %>%
#'   wrap(squares) %>%
#'   keep(~ state %% 3 == 0) %>%
#'   take(5)
#'
#' @export


keep <- function(.generator, .keep) UseMethod('keep')


#' @export

keep.generator <- function(.generator, .keep) {
  keep <- as_function(.keep)
  new_gen <- copy(.generator)
  wrap(new_gen, function(state) {
    val <- new_gen()
    while (!keep(val)) val <- new_gen()
    val
  })
}

#' Filter a series by discarding results that fulfill a predicate
#'
#' @param .generator A function with the class \code{generator}
#' @param .drop A predicate function, returning \code{TRUE} or \code{FALSE}
#'
#' @examples
#' # Generate even numbers
#' counter <- generator(0, ~ state + 1)
#' counter %>% discard(~ state %% 2 == 0) %>% take(5)
#'
#' # Combine a wrap and a counter
#' squares <- function(state) state ^ 2
#' counter %>% wrap(squares) %>% discard(~ state %% 3 == 0) %>% take(5)
#'
#' @export

discard <- function(.generator, .drop) UseMethod('discard')


#' @export

discard.generator <- function(.generator, .drop) {
  drop <- as_function(.drop)
  new_gen <- copy(.generator)
  wrap(new_gen, function(state) {
    val <- new_gen()
    while (drop(val)) val <- new_gen()
    val
  })
}