#' Safely check for next value in iterator
#'
#' @param .generator A function with the class \code{generator}
#'
#' @examples
#' counter <- generator(0, ~ state + 1)
#' peek(counter)
#' counter()
#'
#' @export

peek <- function(.generator) UseMethod('peek')


#' @export

peek.generator <- function(.generator) {
  ahead <- copy(.generator)
  ahead()
}