\name{reweight}
\alias{reweight}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Reweighting of Links from an Adjacency Weighted Matrix }
\description{
  Transforms a weighted matrix into another one constrained into a common scale 
  of relative strength. Values are reweighted by a combination of rewards and 
  punishments. For a given link, its relative strength increases with the number
  of triads where it is the strongest and decreases with the number of triads
  where it is the weakest. 
}
\usage{reweight(wm, similarity = TRUE, t1t2 = if(similarity) c(0, 1) else c(Inf, 0),
  normalized = TRUE)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{wm}{Square and symmetric matrix filled with valued score of spatial affinity.}
  \item{similarity}{Logical, depending on the existence of direct or inverse
                    relationship between matrix scores and the spatial affinity
                    between species (i.e. TRUE: high scores - high affinity; 
                    FALSE: low scores - high affinity).}
  \item{t1t2}{Non-negative numeric vector, conventionally of length 2. }
  \item{normalized}{Logical, if TRUE output values are linearly transformed into
                    the scale [0, 1].}

}
\details{
  The vector \code{t1t2} holds the thresholds to delimit intervals for meaningful
  association. If \code{similarity} is TRUE, any value of the original
  matrix lower than min(t1t2) is discarded for further consideration because it 
  represents the lower bound for meaningful association. On the other hand, any value 
  of the input matrix equal or higher than the upper bound (i.e. max(t1t2)) is deemed
  to be maximally similar and coded 1 in the output. If \code{similarity} is FALSE, 
  any link lower than min(t1t2) represent close affinity between species, and conversely 
  any link equal or higher than max(t1t2) denote no affinity at all between its 
  endvertices.   
  
  The dichotomization is a common procedure to transform weighted matrices into binary ones. 
  Values are set 1 or 0 depending on the location of some cutoff value. This function
  also enables us to perform a hard thresholding when the parameter \code{t1t2} has 
  been fed with a single value. Under this setting, the final reweighted matrix will 
  be binary. If \code{similarity} is TRUE (FALSE), entries are 1 if original values are equal
  or higher (lower) than \code{t1t2}, otherwise entries are 0. 
}
\value{
  A similarity matrix composed of reweighted values. Values are constrained into 
  the interval [0, 1] under the option of normalization. Here, null association is
  coded with a zero (0), whereas the unity (1) corresponds to the optimal meaningful 
  association. 
}
\references{ 
  Dos Santos D.A., Cuezzo M.G., Reynaga M.C., Dominguez E. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\examples{
  #Example to show an interesting numerical property of the reweighting formula, i.e.
  #its convergence to the same rescaled matrix after several self-iterations
  nitems <- 25
  ej <- matrix(0, nitems, nitems)
  ej[row(ej) > col(ej)] <- runif(nitems*(nitems - 1)/2)
  t(ej) + ej -> ej
  diag(ej) <- 1
  ### Display three graphics
  op <- par(mar = rep(3, 4), mfrow = c(3, 1))
  plot(unlist(ej),unlist(reweight(ej)), xlab = "Input matrix", ylab = "Reweighted matrix", main = "First reweighting")
  #Iterative reweighting
  histcor <- c()
  #Perform 100 iterations
  for(i in 1:100) {
    reweight(ej) -> rej
    b <- c()
    for(k in 1:(nrow(ej) - 1))
      for(j in (k + 1):nrow(ej)) {
        a <- (ej[k, j] >= ej[k, ]) + (rej[k, j] >= rej[k, ])
        b <- c(b, sum(a==2)/sum(a > 0))
    }
    histcor <- c(histcor, mean(b))
    ej <- rej
  }
  plot(unlist(ej),unlist(reweight(ej)), xlab = "Input matrix", ylab = "Reweighted matrix",
       main = "Reweighting after several iterations")
  plot(histcor, xlab = "Iteration", ylab = "Cross adjustment",
       main = "Evolution of the resemblance between input and reweigthed network")
  ## At end of plotting, reset to previous settings:
  par(op)
}
\keyword{ methods }
