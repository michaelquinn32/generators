#' @details This package was inspired by Reginald Braithwaite's book on
#' Javascript
#' \href{https://leanpub.com/javascriptallongesix}{Javascript Allonge} and
#' Jeff Knupp's blog post on
#' \href{https://jeffknupp.com/blog/2013/04/07/improve-your-python-yield-and-generators-explained/}{using generators in Python}.
#' It also borrows heavily from
#' \href{https://doc.rust-lang.org/std/iter/trait.Iterator.html}{Rust's iterators methods},
#' which inspired
#' \href{https://doc.rust-lang.org/book/iterators.html}{the framework of iterator adaptors and consumers}.
#'
#' Generators behave much like iterators, which are objects with a mutable
#' internal state. There are multiple implementations of iterators in R. See
#' below.
#'
#' @seealso
#' \href{https://cran.r-project.org/web/packages/iterators/index.html}{iterators}
#' and
#' \href{https://cran.r-project.org/web/packages/itertools/index.html}{itertools}
#'
#' @name generators
#' @importFrom pryr unenclose
#' @importFrom magrittr %>%

"_PACKAGE"