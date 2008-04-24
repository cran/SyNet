\name{overlaphull}
\alias{overlaphull}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Intersection Between Convex Hulls }
\description{
  Determines if species ranges (encoded as convex hulls) overlap. 
}
\usage{
overlaphull(sp1, sp2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sp1}{\code{x} and \code{y} coordinates of points lying on convex hull of
  first species. Coordinates are provided as a list.}
  \item{sp2}{ The same, but for second species. }
}
\details{
  Auxilliary function and not intended to be used by final user.
}
\value{
  One (1) for intersecting convex hulls, otherwise zero (0)
}
\author{ Daniel A. Dos Santos }
\seealso{ 
  function \code{\link{hullinfer}} calls this method.
}
\keyword{ internal }

