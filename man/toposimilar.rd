\name{toposimilar}
\alias{toposimilar}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Resemblance between Process Point Patterns}
\description{
  Produces a weighted matrix of sympatric association between species from 
  their points of occurrence. 
}
\usage{toposimilar(dotdata)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dotdata}{Object of class 'dotdata'}
}
\details{
  This function accounts for the strength of sympatric relationships between
  species. In considering traditional approaches to measure 
  sympatry, distributions are coded into some contour maps and the percentage of
  overlap between distributions is then calculated. Here, there is independence
  from explicit species areas, so arbitrary enclosing areas for the raw points
  of occurrence are avoided. On the contrary, this function focuses on the
  resemblance between patterns of spatial occupancy followed by the records themselves. 
  
  The minimum spanning tree (MST) of species dots are used as the operational tool to
  capture the skeleton of their spatial pattern. If two sets of points associated to a 
  pair of species are both close and interpenetrated (i.e. exhibit a similar
  pattern and likely belong to an underlying area of common membership), the 
  MST of the joint set of points is expected to be formed by several arcs connecting
  interspecific pair of points. For a pair of species, sympatry is considered 
  when their joint set of points gives rises to a MST not longer than the sum of
  the individual MST lengths associated to each species. If two species have a
  single record each, they are considered maximally sympatric if they co-occur
  at the same single point.  
 }
\value{
  Returns a matrix that expresses the spatial similarity between species point sets.
  Non-negative values suggest sympatry and denote the relative strength of
  association in the interval [0, 1].
  Negative values suggest allopatry and correspond (their absolute image)
  to the shortest geographical gap between dot sets.
  }
\references{ 
  Dos Santos D.A., Cuezzo M.G., Reynaga M.C., Dominguez E. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).

  Dos Santos D.A., Deutsch R. 2010. \emph{The Positive Matching Index: a New Similarity
  Measure with Optimal Characteristics.} Pattern Recognition Letters 31: 1570-1576.
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\seealso{
  Objects of class 'dotdata' are created via \code{\link{procdnpoint}}.
}
\examples{
  data(mayflynz)
  aux <- procdnpoint(mayflynz)
  # Infer the weighted sympatry matrix and display 
  # a portion of its entries.
  head(toposimilar(aux)) 
}
\keyword{ methods }
