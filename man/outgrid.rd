\name{outgrid}
\alias{outgrid}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Spatial Expression of Grid Data }
\description{
  Displays a list with operative geographical units (OGUs) associated to each
  unit of co-occurrence.   
}
\usage{
  outgrid(x, namx = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ Object of class 'gridinference'. }
  \item{namx}{ Object of class 'nam'. If NULL \code{nam} function is implemented.}
}
\value{
  A list of character vectors. Elements correspond to spatial expressions
  of units of co-occurrence detected through NAM analysis. 
}
\author{ Daniel A. Dos Santos }
\seealso{ 
\code{\link{nam}} for generating objects of class \code{nam}. 
\code{\link{gridinfer}} for generating objects of class \code{gridinference}.
}
\examples{
data(sciobius2x2) # Obtain grid data about Sciobius distribution.
arg1 <- gridinfer(dntable = sciobius2x2)
arg2 <- nam(arg1)
outgrid(arg1, arg2) 
}
\keyword{ methods }

