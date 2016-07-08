#' Extract n steps from a generator
#'
#' \code{.simplify} uses \code{unlist} and reduces lists to vectors in a
#' similar fashion.
#'
#' @param .generator A function with the class \code{generator}
#' @param .n The number of steps to take
#' @param .simplify If \code{TRUE}, let the function try to simplify the output
#'    instead of returning a list
#'
#' @examples
#' # Simplifying to a vector
#' counter <- generator(0, ~ state + 1)
#' take(counter, 5)
#'
#' # Simplifying to a matrix
#' ran <- generator(c(0, 0), ~ rnorm(2))
#' take(ran, 5)
#'
#' # Returning a list
#' take(ran, 5, FALSE)
#'
#' @export

take <- function(.generator, .n, .simplify) UseMethod('take')


#' @export

take.generator <- function(.generator, .n, .simplify = TRUE) {
  out <- lapply(seq_len(.n), function(i) .generator())
  if (.simplify) simplify2array(out)
  else out
}