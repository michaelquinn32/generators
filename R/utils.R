# Copy attributes from one object and apply them to another

copy_attrs <- function(old, new) {
  attrs <- attributes(old)
  attributes(new) <- attrs
  invisible(new)
}


# Tools for generating functions
# modified from: https://github.com/hadley/purrr/blob/master/R/utils.R
# and https://github.com/hadley/purrr/blob/master/R/partial.R

as_function <- function(.f, ...) UseMethod("as_function")

as_function.function <- function(.f, ...) .f

as_function.formula <- function(.f, ...) {
  if (length(.f) != 2) stop("Formula must be one sided", call. = FALSE)
  args <- alist(state = )
  eval(call("function", as.pairlist(args), .f[[2]]), environment(.f))
}


#' @export

print.generator <- function(x, ...) {
  out <- eapply(environment(x)$env, function(e) {
    if (is.function(e)) pryr::unenclose(e)
    else e
  })

  out[c('yield', 'update', 'env', 'state')]
}
