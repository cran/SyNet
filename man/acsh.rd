\name{acsh}
\alias{acsh}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Average Cost for Spatial Homogenization}
\description{
  Produces a weighted matrix of spatial association between species from 
  points of occurrence. 
}
\usage{
  acsh(dotdata)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dotdata}{Object of class 'dotdata'}
}
\details{
  This function performs pairwise comparisons between species point sets. It calculates
  the average displacement required to achieve homopatry between species. If two species
  share all their records they are said to be homopatric (etymologically,
  with the same territory). 
  
  Given two sets of points A and B, the measure ACSH as described in Dos Santos
  et al. (2011) corresponds to the weighted average across the nearest 
  interspecific distances between the elements of A and B. The weight assigned to 
  each element is proportional to the mean length of MST arcs incident to it. Close
  affinity between distributions is suggested when they deliver an ACSH score near
  to zero.   
 }
\value{
  Returns a matrix that expresses the dissimilarity between species point sets
  via non-negative real values.
  }
\references{ 
  Dos Santos D.A., Cuezzo M.G., Reynaga M.C., Dominguez E. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).
}
\author{
  Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>
}
\seealso{
  Objects of class 'dotdata' are created via \code{\link{procdnpoint}}.
}
\examples{
  data(mayflynz)
  aux <- procdnpoint(mayflynz) #Pre-processing
  head(acsh(aux)) #Generates the dissimilarity matrix and displays some of its values
}
\keyword{ methods }
