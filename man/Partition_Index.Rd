\name{Partition_Index}
\alias{Partition_Index}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Index of Network Partition}
\description{
  Indicates the tendency of a sympatry network to contain species aggregated into 
  locally dense groups, despite the existence of intermediary species connecting them 
  to a more global low density network.  
}
\usage{
  Partition_Index(msym, n = NROW(msym))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{msym}{Matrix object. It must be binary (1/0) and symmetric.}
  \item{n}{Number of nodes.}
}
\details{
  The index is based on clustering coefficient measure (\bold{C}). It 
  considers, for each node, the maximum between its own \bold{C} value 
  and the lowest \bold{C} value at its neighbourhood. The selected value
  is known as clustering performance after Dos Santos et al. (2008). Finally, the 
  mean of clustering performances is obtained.

  This function is for internal use.
}
\value{
  A real number between 0 and 1, where high values suggest the existence of dense
  groups of sympatric species. 
}
\references{
  Dos Santos, D.A., Fernandez, H.R., Cuezzo, M.G., Dominguez, E. \emph{Sympatry 
  Inference and Network Analysis in Biogeography.} Systematic Biology (in press).
}
\author{ Daniel A. Dos Santos}
\seealso{
  This statistic is used by \code{\link{partition}}.
}
\keyword{ internal }

