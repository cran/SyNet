\name{mst}
\alias{mst}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Minimum Spanning Tree}
\description{
  Identifies the minimum spanning tree connecting the set of points using their 
  spatial distances.
}
\usage{
  mst(x) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Distance matrix between points}
}
\details{
  Certainly, a single vector could be used to capture the topology of a MST,
  indicating the index of the parent node for each child node. However, I have decided 
  to indicate the endpoints for each MST arc into two separate vectors.
}
\value{
  This function returns a list with the following elements:
  \item{path}{Length of the MST in the given metric units.}
  \item{wght}{Mean leangth of MST arcs incident to each vertex. Values are normalized so that they sum to unity.}
  \item{xy0}{Indices for one of the endpoints of MST arcs.}
  \item{xy1}{Indices for the other endpoints correspondingly ordered.}
}
\references{ 
  Prim R.C. 1957. \emph{Shortest Connecting Networks and Some Generalizations.} Bell Syst. Tech. J
  36:1389-1401.
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\note{
  The algorithm to obtain the MST is valid for distance matrices with metric properties. 
  Consequently, both Euclidean and orthodromic distances can be used. 
}
\examples{
  xy <- matrix(rnorm(100), ncol = 2) # Sample a random set of points
  plot(xy, xlab = "", ylab = "", main = "MINIMUM SPANNING TREE")
  aux <- mst(as.matrix(dist(xy))) # Find the Euclidean minimum spanning tree
  segments(xy[aux$xy0,1], xy[aux$xy0,2], xy[aux$xy1,1], xy[aux$xy1,2]) # Plot the MST
}
\keyword{ methods }
