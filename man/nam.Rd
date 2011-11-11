\name{nam}
\alias{nam}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Sympatry Network Analysis }
\description{
  Seeks groups of species cohesively sympatric (units of co-occurrence) via
  iterative removal of nodes with the highest betweenness score (intermediary species). 
  It also provides geometric data to plot a cleavogram. 
}
%- maybe also 'usage' for other objects documented here.
\usage{ 
  nam(input, rounding = TRUE)
}
\arguments{
  \item{input}{An object of sympatry inference. Admitted classes are both 'dotinference' 
               and 'gridinference'.}
  \item{rounding}{Logical. If TRUE, betweenness scores are rounded via zapsmall set at 
                  8 digits.} 
}
\details{
  The argument \code{input} contains an element $sm, i.e. a sympatry matrix \bold{S} of 
  order \emph{n} (= number of species). Each entry \emph{Sij} is 1 if there is a 
  sympatric link between species \emph{i} and \emph{j}, while \emph{Sij} is 0 if 
  allopatry is suggested. The diagonal elements are 1 because sympatry is reflexive. 
  Furthermore, sympatry matrix is symmetric due to reciprocal nature of this relationship.

  Sympatry matrices are adjacency matrices, and finding the connection patterns in 
  the associated network is the scope of \code{nam} function. In a given 
  sympatry network, nodes represent species and edges sympatric links. \code{nam} 
  is an iterative process of node removal to isolate subsets of nodes with within-group
  sympatry and between-group allopatry (units of co-occurrence). Units of co-occurrence 
  are generally embedded into a global network due to connecting intermediary nodes.

  \code{nam} identifies and removes nodes with the highest intermediacy score.
  Intermediacy is evaluated with the betweenness measure (Freeman, 1977). After the 
  node removal, a sub-network is generated and the process is repeated until it arrives 
  at a sub-network with all nodes with zero betweenness. In this way, \code{nam}
  produces a series of sub-networks. 
  
  Dos Santos et al. (2011) describes a new graphical tool, called a cleavogram, 
  that depicts the structural changes of the network along the removal process.
  This function also retrieves the necessary information to plot a cleavogram. 

  The older version of NAM method focused on the structure of a single sub-network
  Dos Santos et al. (2008). Now, the interest relies on the cohesiveness of the various
  components emerging during the removal process. 
  
  The density describes the general level of linkage among the vertices (or nodes)
  in a network. A 'complete' graph (density = 1) is one in which all the actors
  are adjacent to one another. The density of a graph is the fraction of edges it
  actually has out of all possible vertex pairs.   

  Transitivity measures the probability that the adjacent vertices of a vertex are
  connected. This sometimes is also called the global clustering coefficient. It
  calculates the number of existing transitive triangles proportional to the number
  of connected triples.  

  In graph theory, the distance between two vertices in a graph is the number of
  edges in the shortest path connecting them (i.e., the geodesic distance). If there 
  is no path connecting the two vertices, they belong to different connected components.
  The eccentricity of a vertex v is the greatest geodesic distance between v and
  any other vertex. It can be thought of as how far a node is from the node most
  distant from it in the graph. The diameter of a graph is the maximum eccentricity
  of any vertex in the graph. That is, it is the greatest distance between any pair
  of vertices. Groups of vertices tightly connected is expected to have a small diameter.
}
\value{
  An object of class \code{cleavogram}, which is a list with components:
  \item{mt}{Input adjacency matrix with its rows and columns rearranged 
  according to the sequence of leaves in the cleavogram.} 
  \item{LastNet}{Integer vector indicating the last network (or sub-network)
  where a given node was found. Zero for the basal network and >0 for successive 
  sub-networks.}
  \item{namlast}{As previously referred but adding 2 to each element.}  
  \item{Betweenness}{ Highest betweenness value recorded at the respective 
  instance of removal process. }
  \item{leaves}{Character vector concerning to the labels of nodes in the network.}
  \item{nsp}{Integer corresponding to the size of the network.}
  \item{nsub}{Integer corresponding to the number of sub-networks obtained during
  removal process.}  
  \item{components}{This is the core of the analysis. Data frame that indicates 
  the structure of each component obtained along with the removal process. Additionally,
  there are statistical estimates for the cohesiveness of each component that have
  been detected (i.e. density, transitivity and eccentricities).}  
  \item{verticals}{Data matrix that includes information about the vertical segments 
  of the cleavogram.}
  \item{kind}{Character. Either 'grids' or 'points'. Describes how spatial information has
  been encoded.}
  \item{occupancy}{List of occurrences for each taxon under study (i.e. each node of the 
  network}
  \item{coords}{Two-columns matrix. Spatial coordinates of the records in the data set.}
}
\references{ 
  Costa L.F., Rodrigues F.A., Travieso G., Boas V.P.R. 2005. 
  \emph{Characterization of Complex Networks: A Survey of Measurements.} 
  Advances in Physics, 56(1), 167-242.

  Dos Santos D.A., Fernandez H.R., Cuezzo M.G., Dominguez E.
  2008.\emph{ Sympatry Inference and Network Analysis in Biogeography.} 
  Systematic Biology 57:432-448.

  Dos Santos D.A., Cuezzo M.G., Reynaga M.C., Dominguez E. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).
  
  Freeman L. C. 1977. \emph{A Set of Measures of Centrality Based on Betweenness.}
  Sociometry 40:35-41.

  Newman M. E. J. 2001. \emph{Scientific Collaboration Networks. II. Shortest Paths,
  Weighted Networks and Centrality.} Phys. Rev. E 64:016132.

  Seidel R. 1995. \emph{On the All-Pairs-Shortest-Path Problem in Unweighted 
  Undirected Graphs.}In Proceedings of J. Comput. Syst. Sci.: 400-403. 
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\note{ 
  Betweenness measure was calculated with Newman's algorithm (Newman, 2001).
  Geodesic distances between vertices was calculated following Seidel (1995).
}
\seealso{ 
  The cleavogram can be explored with function \code{\link{cleavogram}}.\cr
}
\examples{
  data(sciobius2x2)
  mtx <- gridinfer(dntable = sciobius2x2, reciprocity = FALSE) # Infers the sympatry network 
  cleavosciobius <- nam(mtx) # Performs NAM analysis and create cleavogram called 'cleavosciobius'
  \dontrun{
  cleavogram()
  }
  # Choose the previous cleavogram and dissect it! 
}
\keyword{methods}
\keyword{iteration}

