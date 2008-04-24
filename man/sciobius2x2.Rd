\name{sciobius2x2}
\alias{sciobius2x2}
\docType{data}
\title{Sciobius Grid Occupancy Data}
\description{
  Presence/absence data of 47 South African \emph{Sciobius} species along a square 
  grid of 2 x 2 degrees.
}
\usage{data(sciobius2x2)}
\format{
  A data frame with 47 observations on 25 grid cells.
}
\details{
 Original matrix is derived from Morrone (1994). An ulterior correction is introduced
 by Mast and Nyffeler (2003). We refer to this last version. Moreover, we adopt the 
 same codification of species names. 
}
\source{
  Morrone, J. J. 1994. \emph{On the identification of areas of endemism.} Syst. Biol. 43:438-441.

  Mast, A. R., and R. Nyffeler. 2003. \emph{Using a null model to recognize significant co-
  occurrence prior to identifying candidate areas of endemism.} Syst. Biol.  52:271-280.
}
\examples{
# Apply NAM analysis on Sciobius data set.
data(sciobius2x2)
fornam <- gridinfer(dntable = sciobius2x2)
namsc <- nam(fornam)
# Obtain the species belonging to each unit of co-occurrence
split(namsc$Categories[,1], namsc$Categories[,2])

}
\keyword{datasets}
