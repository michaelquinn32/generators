---
output: html_document
---
# Generators: A grammar of iteration

Generators are functions that behave like iterators, a type of object that 
contains a mutable internal state. When used correctly, they offer an efficient 
solution to many computational problems. This package provides a grammar for 
working with these tools.

This package was written to accompany a post on [The Big Blog of R 
Adventures](http://michaelquinn32.github.io/). It provides much more detail
on how design and implementation of this project.

## Design concepts and goals

### Constructing generators

Iterators typically contain a next method to create new values of the internal
state. Generators accomplish this through successive function calls. In R, we
can implement this tool using closures. The simplest of these is the 
counter. [Using an example from Hadley
Wickham](http://adv-r.had.co.nz/Functional-programming.html#closures), we can
implement a simple count generator as follows,

```r
counter <- function() {
  i <- 0
  function() {
    i <<- i + 1
    i
  }
}
```

This is what it looks like in action.

```r
my_counter <- counter()
my_counter()
#> 1
my_counter()
#> 2
```

This simple function has a very useful structure that can built upon to create 
a much more general tool:

* At the heart of it all, we have a mutable state: `i`.
* We modify it with the scoping assignment operator `<<-`. 
* Subsequent calls to the function *update* the state. 
* And each call returns (a version of) the changed state.

Together, these components form the arguments of the function `generator`.

* `.state` is a vector. It doesn't necessarily have to be a scalar
* `.update` controls how that state changes over time
* `.yield` governs how values from the state are returned to form the series

### Working with iterators

A wide variety of iterators can be constructed using these three arguments, but
many users might want to use other tools to create new generators. For these
purposes, the following are provided:

* `copy` create a new generator whose state does not affect the original
* `keep` or `discard` controls which elements of the series are shown
* `wrap` changes the series output, while `rebase` changes the update function
* `skip` moves the series forward a specific number of steps
* `take` transforms a set number of values into a list or vector
* `reset` sends it back to its start
* `limit` provides an end to the series (when the series is exhausted)
* `recycle` resets the generator when it is exhausted
* `consume` generates the series until its limits
* `foldn` and `foldc` reduces the series to a single value, using a binary 
function

## Other iteration tools

Generators are a common type of object in many programming languages, and this 
package draws heavily from concepts impelemented in Javascript and 
Python. Reginald Braithwaite's book, 
[*Javascript Allonge*](https://leanpub.com/javascriptallongesix), has an 
excellent introduction to generators in that language, and I learned about 
their implementation in Python thanks to 
[Jeff Knupp's blog](https://jeffknupp.com/blog/2013/04/07/improve-
your-python-yield-and-generators-explained/).

An iterator syntax is provided in Rust. It is described well in 
[Rust's documentation](https://doc.rust-lang.org/std/iter/trait.Iterator.html) 
and [its accompanying book](https://doc.rust-lang.org/book/iterators.html). 
These concepts informed the generator grammar described in this package.

Iterators already exist in R, through the [`iterators`](https://cran.r-project.org/web/packages/iterators/index.html) and
[itertools](https://cran.r-project.org/web/packages/itertools/index.html) 
packages, but the implementations and design goals are different. This package 
is obviously indebted to Rich Calaway, Steve Weston and Hadley Wickham for 
their work, and I am incredibly grateful to be able to reference it.

## Installation

To install the development version of this package:

```r
# install.packages("devtools")
devtools::install_github("michaelquinn32/generators")
```