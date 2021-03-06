% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fold.R
\name{foldn}
\alias{foldn}
\title{Fold a generator N times with a binary function}
\usage{
foldn(.generator, .n, .FUN, ..., .start = 0)
}
\arguments{
\item{.generator}{A function with the class \code{generator}}

\item{.n}{The number of iterations to produce}

\item{.FUN}{A binary fold function to reduce the generator to a single value}

\item{...}{Additional arguments to .FUN}

\item{.start}{The starting value for the reduction}
}
\description{
\code{foldn} is the generator-equivalent of the function \code{\link{Reduce}}.
It takes a generator, produces \code{.n} values and applies a binary
function iteratively, returning a scalar.
}
\examples{
# Sum from 1 to 10
counter <- generator(0, function (state) state + 1)
counter \%>\% copy \%>\% foldn(10, `+`)

}

