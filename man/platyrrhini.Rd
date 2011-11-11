\name{platyrrhini}
\alias{platyrrhini}
\docType{data}
\title{ Neotropical Primates }
\description{
  Distributional data of Neotropical primates arranged into an object of 
  class \code{dnpoint}.     
}
\usage{data(platyrrhini)}
\format{
  The format is:
List of 4
 $ Numpoints: int 602
 $ Points   :'data.frame':	602 obs. of  3 variables:
  ..$ IDsp    : num [1:602] 1 1 1 1 1 1 1 1 1 2 ...
  ..$ Longitud: num [1:602] 9 10 11 12 9 10 11 12 13 10 ...
  ..$ Latitud : num [1:602] 6 6 6 6 7 7 7 7 7 5 ...
 $ Label    : chr [1:106] "1" "10" "100" "101" ...
 $ Type     : chr "cartesian"
 - attr(*, "class")= chr "dnpoint"
}
\details{
  Goldani et al. (2006) coded the distribution of 106 Neotropical primate (Platyrrhini)
  species into 60 quadrats of 5 x 5 degrees as OGUs, detecting eight areas of endemism.
  Here, each species cell record was transformed into a punctual record so that its x and y
  coordinates are the respective column and row numbers of the cell in the original grid
  system. Numeric codes for species labels are the same as in Goldani et al. (2006).
}
\source{
  Goldani A., Carvalho G.S., Bicca-Marques J.C. 2006. \emph{Distribution Patterns
  of Neotropical Primates (Platyrrhini) Based on Parsimony Analysis of Endemicity.}
  Braz. J. Biol. 66(1a): 61-74.
}
\references{
  Dos Santos D.A., Cuezzo M.G., Reynaga M.C., Dominguez E. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).
}
\keyword{datasets}
