#' Copy a generator safely
#'
#' Assigning a new name to a generator does not break the link with the
#' underlying state. Calling the new generator will update the state in the
#' previous too. This is an unsafe copy. To break this link, and spawn a new
#' underlying state, use this function.
#'
#' @param .generator A function with the class \code{generator}
#'
#' @examples
#' # Unsafe copy
#' counter <- generator(0, ~ state + 1)
#' counter2 <- counter
#' counter2(); counter(); counter()
#' identical(counter, counter2)
#'
#' # Safe copy
#' counter2 <- copy(counter)
#' counter2(); counter(); counter()
#' identical(counter, counter2)
#'
#' @export

copy <- function(.generator) UseMethod('copy')


#' @export

copy.generator <- function(.generator) {
  gen <- generator(get_state(.generator),
                   get_update(.generator),
                   get_wrapper(.generator))

  copy_attrs(.generator, gen)
}