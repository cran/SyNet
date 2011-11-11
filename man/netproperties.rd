\name{netproperties}
\alias{netproperties}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Structural Properties of an Unweighted Undirected Network }
\description{
  Calculates i) density of the network, ii) node degrees, iii) geodesic distances
  between pairs of vertices. It also finds components and enumerates 
  maximal cliques in the network. 
}
%- maybe also 'usage' for other objects documented here.
\usage{netproperties (mt, cutoff = 0, dichotomization = ">")}
\arguments{
  \item{mt}{Any valued symmetric matrix.}
  \item{cutoff}{Numeric. It is the threshold that dichotomizes the input matrix.} 
  \item{dichotomization}{Character. Dichotomization rule expressed as a comparison
  operator.}
}
\details{
  The input matrix is transformed into a binary adjacency matrix applying the 
  dichotomization rule over the cutoff. Then, several connecting properties of 
  the resulting simple graph are studied. 
  
  A brief summary of graph concepts follows. The density is the proportion
  of dyadic connections (links) which are actually present. The degree of a node
  is the number of neighbors directly tied to that node. Cliques are fully connected 
  groups of nodes, that is complete subgraphs in a graph. A clique is maximal if
  it cannot be extended to a larger clique. In graph theory, the distance between
  two vertices is the number of edges in a shortest path connecting them. A connected
  component of an undirected graph is a subgraph in which any two vertices
  are connected to each other by paths, and which is connected to no additional vertices.
  If there is no path connecting the two vertices, i.e. if they belong to different
  connected components, then conventionally the geodesic distance can be defined as NA 
  or infinite.
}
\value{
  An object of class \code{cleavogram}, which is a list with components:
  \item{Adjacency}{Binary matrix resulting from dichotomization.} 
  \item{Components}{A vector of integers indicating the component to which each
  vertex (or node) is allocated.} 
  \item{Degree}{A vector of integers indicating the number of neighbors directly 
  linked to each vertex (or node).} 
  \item{Geodesic}{ Geodesic distance matrix between vertices. If two vertices belong to 
  different components, the respective entry is set NA.} 
  \item{Cliques}{Data frame. Columns are maximal cliques whereas rows are vertices of
  the network. Membership of each node to maximal cliques are indicated through 1 (present)
  and 0 (absent).}
}
\references{ 
  Bron C., Kerbosch J. 1973. \emph{Algorithm 457: Finding All Cliques of an
  Undirected Graph.} Commun. ACM 16(9): 575-577. 

  Seidel R. 1995. \emph{On the All-Pairs-Shortest-Path Problem in Unweighted 
  Undirected Graphs.}In Proceedings of J. Comput. Syst. Sci.: 400-403. 
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\note{ 
  Geodesic distances between vertices was calculated following Seidel (1995).
  Maximal cliques have been enumerated following the recursive algorithm of 
  Bron and Kerbosch (1973).
}
\examples{
  # "A" corresponds to the 0-1 adjacency matrix
  # associated to a simple graph of 10 nodes
  # The main diagonal has zeroes.
  A <- matrix(0, 10, 10)
  A[lower.tri(A)] <- ifelse(runif(5*9) < 0.5, 1, 0)
  pmin(A + t(A), 1) -> A
  netproperties(A)
}
\keyword{methods}
