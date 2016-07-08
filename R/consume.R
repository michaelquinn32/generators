#' Consume an generator, taking all iterations up to a limit
#'
#' \code{consume} is a special version of \code{take}, with additional controls
#' to help the user. It produces the same output and warns the user (through
#' guess) if the number of iterations taken is insufficient to reach the limit.
#'
#' It needs to be preceded by a \code{limit} to a generator.
#' The function checks whether a generator is limited, but other errors are
#' possible if the limit occurs earlier in the chain of wrappers.
#'
#' @param .generator A function with the class \code{generator}
#' @param .guess An approximate number of steps until the limit
#' @param .simplify If \code{FALSE} return a list, else return an array
#'
#' @examples
#' # A typical example
#' counter <- generator(0, function (state) state + 1)
#' counter %>% limit(~ state < 20) %>% consume
#'
#' # Should throw a warning
#' \dontrun{
#' counter %>%
#'   reset %>%
#'   limit(~ state < 20) %>%
#'   consume(10)
#' }
#'
#' @export

consume <- function(.generator, .guess, .simplify) UseMethod('consume')


#' @export

consume.generator <- function(.generator, .guess = 1000, .simplify = FALSE) {
  if (is_limited(.generator)) {
    wrapped <- wrap(.generator, function(state) {
      tryCatch(state, error = function(e) NULL)
    })

    out <- take(wrapped, .guess, .simplify)
    if (!is.null(wrapped())) {
      warning('Generator not exhausted, increase .guess', call. = FALSE)
    }

    out

  } else stop('A generator must have a limit to consume', call. = FALSE)
}