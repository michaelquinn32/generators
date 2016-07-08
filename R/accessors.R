#' Accessor methods for the generator class
#'
#' These functions make it possible to access various aspects of the generator
#' class.
#'
#' @param .generator A function with the class \code{generator}
#'
#' @description
#' \describe{
#'  \item{\code{get_start}}{Get the starting state of a generator}
#'  \item{\code{get_state}}{Get the current state of a generator}
#'  \item{\code{get_series}}{Get the current series value of a generator}
#'  \item{\code{get_update}}{Get the updating function of a generator}
#'  \item{\code{get_wrapper}}{Get the wrapper/ yield function of a generator}
#'  \item{\code{is_limited}}{Binary: show if the generator has a limiting
#'      function}
#'  \item{\code{is_exhausted}}{Binary: show if the generator is exhausted}
#' }
#'
#' @name accessors

NULL


#' @rdname accessors
#' @export

get_start <- function(.generator) UseMethod('get_start')


#' @export

get_start.generator <- function(.generator) attr(.generator, 'start')


#' @rdname accessors
#' @export

get_state <- function(.generator) UseMethod('get_state')


#' @export

get_state.generator <- function(.generator) environment(.generator)$state


#' @rdname accessors
#' @export

get_series <- function(.generator) UseMethod('get_series')


#' @export

get_series.generator <- function(.generator) {
  env <- environment(.generator)
  env$yield(env$state)
}


#' @rdname accessors
#' @export

get_update <- function(.generator) UseMethod('get_update')


#' @export

get_update.generator <-function(.generator) environment(.generator)$update


#' @rdname accessors
#' @export

get_wrapper <- function(.generator) UseMethod('get_wrapper')


#' @export

get_wrapper.generator <-function(.generator) environment(.generator)$yield


#' @rdname accessors
#' @export

is_limited <- function(.generator) UseMethod('is_limited')


#' @export

is_limited.generator <- function(.generator) attr(.generator, 'limited')


#' @rdname accessors
#' @export

is_exhausted <- function(.generator) UseMethod('is_exhausted')


#' @export

is_exhausted.generator <- function(.generator) {
  tryCatch({
    peek(.generator)
    FALSE
  },
  error = function(e) TRUE)
}