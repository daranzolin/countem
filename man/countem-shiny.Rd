% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/countem.R
\name{countem-shiny}
\alias{countem-shiny}
\alias{countemOutput}
\alias{renderCountem}
\title{Shiny bindings for countem}
\usage{
countemOutput(outputId, width = "100\%", height = "400px")

renderCountem(expr, env = parent.frame(), quoted = FALSE)
}
\arguments{
\item{outputId}{output variable to read from}

\item{width, height}{Must be a valid CSS unit (like \code{'100\%'},
\code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
string and have \code{'px'} appended.}

\item{expr}{An expression that generates a countem}

\item{env}{The environment in which to evaluate \code{expr}.}

\item{quoted}{Is \code{expr} a quoted expression (with \code{quote()})? This
is useful if you want to save an expression in a variable.}
}
\description{
Output and render functions for using countem within Shiny
applications and interactive Rmd documents.
}
