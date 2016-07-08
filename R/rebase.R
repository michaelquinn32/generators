#' Alter a generators update function, spawning a new generator
#'
#' In general, it's not very good idea to alter the update of an generator.
#' If a different update is needed, you can always write a new generator, and
#' if one is needed in a chain of calls, \code{\link{wrap}}is usually a better
#' option.
#'
#' That said, when used appropriately, rebasing is very useful. For example, it
#' powers several other tools in this package, like \code{\link{recycle}}.
#'
#' @param .generator A function with the class \code{generator}
#' @param .FUN A function to wrap the current \code{update}
#' @param .wrapper A function to replace the current wrapper
#'
#' @examples
#' counter <- generator(0, ~ state + 1)
#' times_two <- function(x) x * 2
#' skipping <- rebase(counter, times_two)
#' take(skipping, 5)
#'
#' @export

rebase <- function(.generator, .FUN, .wrapper = get_wrapper(.generator)) {
  UseMethod('rebase')
}


#' @export

rebase.generator <- function(.generator, .FUN,
                             .wrapper = get_wrapper(.generator)) {
  f <- as_function(.FUN)
  g <- get_update(.generator)
  update <-  function(state) f(g(state))
  gen <- generator(get_state(.generator), update, .wrapper)
  copy_attrs(.generator, gen)
}