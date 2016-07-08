#' Return a generator to its original state
#'
#' @param .generator A function with the class \code{generator}
#'
#' @examples
#' counter <- generator(0, ~ state + 1)
#' take(counter, 5)
#' reset(counter)
#' counter()
#'
#' @export

reset <- function(.generator) UseMethod('reset')


#' @export

reset.generator <- function(.generator) {
  assign('state', get_start(.generator), environment(.generator))
  invisible(.generator)
}
