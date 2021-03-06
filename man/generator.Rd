% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generator.R
\name{generator}
\alias{generator}
\title{Construct a new generator}
\usage{
generator(.start, .update, .yield = identity)
}
\arguments{
\item{.start}{A vector that describes the initial state of the generator}

\item{.update}{A function or formula controlling how the state changes
over time}

\item{.yield}{A function or formula controlling how a series is returned
from the state}
}
\description{
A generator is a function that contains a mutable state. Calls to the
function change the state and return a value in a series.
}
\details{
Syntax sugar is borrowed from
\href{https://github.com/hadley/purrr/}{\code{purrr}}, allowing for
the creation of anonymous functions using formulas. Unlike \code{purrr},
this package uses \code{state} as the key pronoun for all functions.
}
\examples{
# The simplest form of generator is a counter
my_counter <- generator(0, ~ state + 1)

# More complicated generators also need a yield.
my_fib <- generator(c(0, 1),
                    ~ c(state[2], sum(state)),
                    ~ state[1])
take(my_fib, 5)

}

