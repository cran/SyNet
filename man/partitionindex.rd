\name{partitionindex}
\alias{partitionindex}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Partition Index of a Sympatry Network }
\description{
  Calculates the actual partition index of a simple sympatry network and estimates
  its random expectancy under a Bernoulli graph model. 
}
\usage{partitionindex(iptsymp, replica = 1)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{iptsymp}{Adjacency matrix associated to the network of interest.}
  \item{replica}{Integer between 1 and 5000. Corresponds to the number of random
                 adjacency matrices to be generated.}
}
\details{
  The partition index (\bold{PI}) is based on the clustering coefficient measure (\bold{C}).
  For each network node, it takes into account the maximum between its own \bold{C} value 
  and the lowest \bold{C} value recorded at its open neighbourhood. The selected value
  is known as clustering performance after Dos Santos et al. (2008). Finally, the 
  mean of clustering performance is calculated.
  
  (\bold{PI}) is the statisitc to test the adequacy of the the newtork to be segregated
  into highly connected groups of species. The test counts the number of random 
  simple graphs that yields a \bold{PI} value higher or equal to the observed one. 

  Random expectancy for (\bold{PI}) is based on matrices following a Bernoulli model.
  A random number between 0 and 1 is generated for each pair of species in the network. 
  If this number is lower than the observed density for the the network, the respective 
  pair of species will remain tied in the random network. 

  The input argument \code{iptsymp} corresponds to any adjacency matrix that 
  reflects the incidence (1) or not (0) of a sympatric link between pairs of 
  species. If the input matrix is valued, scores higher than 
  zero will be automatically coded 1 (otherwise, they will be coded 0). 
}
\value{
  If \code{replica} > 1, returns a list containing:
  \item{ProbTie}{Density of network associated to.}
  \item{PIobserved}{Observed (\bold{PI}). }
  \item{PIrandomized}{Statistical summary of the randomly expected indices calculated 
                       through \code{\link{fivenum}}.}
  \item{ProbTie}{Fraction of random scenarios where the calculated (\bold{PI})
                  is higher than (or equal to) the observed one.}
  
  If \code{replica} = 1, the (\bold{PI}) of the observed matrix is calculated.  
}
\references{
  Dos Santos D.A., Fernandez H.R., Cuezzo M.G., Dominguez E. 2008. \emph{Sympatry 
  Inference and Network Analysis in Biogeography.} Systematic Biology 57:432-448. 
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\examples{
  #Creates a Bernoulli graph of 100 nodes
  A <- matrix(0, 100, 100)
  aux <- ifelse(runif(choose(100, 2)) <= 0.3, 1, 0)
  A[row(A) > col(A)] <- aux
  A + t(A) -> A
  #Prints the partition index on the R console
  partitionindex(A)
  #Produces 10 random samples and test significancy 
  partitionindex(A, 100)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ aplot }
\keyword{ methods }

