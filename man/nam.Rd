\name{nam}
\alias{nam}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Sympatry Network Analysis }
\description{
  Performs the analysis of a sympatry network oriented to detect groups of species
  cohesively sympatric (units of co-occurrence) via iterative removal of nodes
  with high betweenness score (intermediary species).
}
%- maybe also 'usage' for other objects documented here.
\usage{ 
  nam(msym)
}
\arguments{
  \item{msym}{Object of classes 'dotinference', 'gridinference' or 'hullinference'.} 
}
\details{
  The input argument \code{msym} contains a sympatry matrix \bold{S} of 
  order \emph{n} (= number of species). Each entry \emph{Sij} is 1 if there is a 
  sympatric link between species \emph{i} and \emph{j}, while \emph{Sij} is 0 if 
  allopatry is suggested. The diagonal elements are 1 because sympatry is reflexive. Furthermore, sympatry matrix is symmetric due to reciprocal nature of this relationship.

  Sympatry matrices are adjacency matrices, and finding the connection patterns in 
  the associated network is the scope of \code{nam} function. In a given 
  sympatry network, nodes represent species and edges sympatric links. \code{nam} 
  is an iterative process of node removal to isolate subsets of nodes with within-group
  sympatry and between-group allopatry (units of co-occurrence). Units of co-occurrence 
  are generally embedded in the global network due to intermediary nodes connecting 
  them.

  \code{nam} identifies and removes nodes with the highest intermediacy.
  Intermediacy is evaluated with the betweenness measure (Freeman, 1977). After the 
  node removal, a sub-network is generated and the process is repeated until it arrives 
  to a sub-network with all nodes with zero betweenness. In this way, \code{nam}
  produces a serie of sub-networks, one of them holding the units of co-occurrence. 

  As units of co-occurrence are being segregated, the overall clustering performance
  (\bold{OCP}) increases. This index reflects the change in clustering 
  performance along all nodes of a sub-network with respect to the basal condition
  (Dos Santos et al., 2008). The sub-network maximizing \bold{OCP} is selected.
  Here, the components with 3 or more nodes represent the units of co-occurrence
  we are interested on. 
}
\value{
  An object of class \code{nam}, which is a list with components:
  \item{LastNet      }{ Integer vector indicating the last network (or sub-network)
  where a given node was found. Zero for the basal network and >0 for succesive 
  sub-networks.}
  \item{Betweenness  }{ Highest betweenness value recorded at the respective 
  instance of removal process. }
  \item{OCPtrajectory}{Serie of \bold{OCP} values recorded along 
  the removal process.} 
  \item{Selected      }{Index of sub-network selected.}
  \item{Categories    }{Data frame that arranges species into four categories
  of \bold{NAM} Status. See Note below.} 
  
  Simultaneously, the function displays a graph showing the evolution of \bold{OCP}
  throughout the removal process (y-axis: index value; x-axis: sub-network considered).  
}
\references{ 
  Freeman, L. C. 1977. \emph{A set of measures of centrality based on betweenness.}
  Sociometry 40:35-41.

  Newman, M. E. J. 2001. \emph{Scientific collaboration networks. II. Shortest paths,
  weighted networks and centrality.} Phys. Rev. E 64:016132.

  Dos Santos, D. A., Fernandez, H. R., Cuezzo, M. G., Dominguez, E.
  2008.\emph{ Sympatry Inference and Network Analysis in Biogeography. } 
  Systematic Biology (in press).
}
\author{ Daniel A. Dos Santos }
\note{ 
Betweenness measure was calculated with Newman's algorithm (Newman, 2001).

NAM classifies species into four categories: Intermediary species, Isolated species, 
Diad and Unit of Co-occurrence(UC).  
}
\seealso{ 
  Objects of class 'dotinference' are produced with function \code{\link{dotinfer}}.\cr
  Objects of class 'gridinference' are produced with function \code{\link{gridinfer}}.\cr
  Objects of class 'hullinference' are produced with function \code{\link{hullinfer}}.\cr
  Previous to \bold{NAM} analysis, is necessary to test the network adequacy 
  to be segregated into units of co-occurrence:\code{\link{partition}}.\cr
  Concept of clustering performance is summarized in Details section of 
  \code{\link{partition}} documentation.   
}
\examples{
 data(epiphragmophora)
 nam(dotinfer(epiphragmophora))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{aplot}
\keyword{methods}
\keyword{iteration}
