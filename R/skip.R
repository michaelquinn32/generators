#' Skip ahead in a generator
#'
#' @param .generator A function with the class \code{generator}
#' @param .n The number to steps to move forward
#'
#' @examples
#' counter <- generator(0, ~ state + 1)
#' skip(counter, 5)
#' counter()
#'
#' @export

skip <- function(.generator, .n) UseMethod ('skip')


#' @export

skip.generator <- function(.generator, .n) {
  n <- 0

  while (n < .n) {
    n <- n + 1
    .generator()
  }

  invisible(.generator)
}