\name{partition}
\alias{partition}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Test of Adequacy }
\description{
  Tests the capability of a sympatry network to contain units of co-occurrence.
}
\usage{
  partition(iptsymp, replica = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{iptsymp}{Matrix object. It must be binary (1/0) and symmetric.}
  \item{replica}{Number of random matrices to be produced.}
}
\details{
  The input argument \code{iptsymp} corresponds to any adjacency matrix that 
  reflects the incidence (1) or not (0) of a sympatric link between pairs of 
  species. 
  
  Random matrices are generated according to a Bernoulli model. A random number 
  between 0 and 1 is generated for each pair of species or cell. If this
  number is lower than the density of the network associated to the observed matrix, 
  a 1 score is assigned. 

  The statisitc corresponds to the Partition Index (\bold{PI}). The test counts 
  the number of random matrices that yields a \bold{PI} value
  higher or equal to the observed one. 
}
\value{
  If \code{replica} > 1, a list is generated with the following components:
  \item{$Input       }{Sympatry matrix observed.}
  \item{$ProbTie     }{Density of network associated to.}
  \item{$NodeNr      }{Number of nodes considered.}
  \item{$PIobserved  }{Observed Partition Index. }
  \item{$PIrandomized}{Statistical summary of randomized Partition Index.}
  \item{$ProbTie     }{Fraction of \code{replica} where the randomized Partition
  Index is >= the observed one.}
  
  If \code{replica} = 1, the Partition Index of the observed matrix is calculated.  
}
\references{
  Dos Santos, D.A., Fernandez, H.R., Cuezzo, M.G., Dominguez, E. \emph{Sympatry 
  Inference and Network Analysis in Biogeography.} Systematic Biology (in press). 
}
\author{ Daniel A. Dos Santos }
\seealso{
  The statistic \bold{PI} is calculated by the function \code{\link{Partition_Index}} 
}
\examples{
data(epiphragmophora)
p <- dotinfer(epiphragmophora)
partition(p[[1]], 100)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ aplot }
\keyword{ methods }
