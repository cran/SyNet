\name{stablecouple}
\alias{stablecouple}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Stable Matching Derived from Spatial Affinity Matrices}
\description{
  Produces a partition into stable couples from a set of species arranged into
  a symmetric matrix of spatial affinity. Self-matched elements are allowable. 
}
\usage{
  stablecouple(mt, selfprefmethod = "customized", similarity = TRUE, 
  initselfpref = if(similarity) 1e-07 else median(mt[lower.tri(mt)]), 
  prob = 0.5) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mt}{Square and symmetric matrix filled with valued score of spatial affinity.}
  \item{selfprefmethod}{String specifying the method to set the main diagonal of selfpreferences.
                        Options are "two-means", "mean", "quantile" and "cutomized".}
  \item{similarity}{Logical, depending on the existence of direct or inverse
                    relationship between matrix scores and the spatial affinity
                    between species (i.e. TRUE: high scores - high affinity; 
                    FALSE: low scores - high affinity).}
  \item{initselfpref}{Numeric vector, it is forced to have the same length as
                      the number of matrix rows. If NULL, it is directly replaced 
                      by the main diagonal of the input matrix itself. This vector 
                      bounds the domain of selfpreferences for each species. Thus, 
                      for a given species with initial selfpreference set at k,  
                      associations with other species are taken into account 
                      if their values belong to the interval [k, 1] (or [0, k])
                      in the similarity (or dissimilarity) matrix.}
  \item{prob}{Single numeric value between 0 and 1 used as probability for the
              method \bold{"quantile"}. The default value of 0.5
              corresponds to the median. }
}
\details{
  The stable marriage problem is that of matching \emph{n} men and \emph{n} women,
  each of whom has ranked the members of the opposite sex in order of preference,
  so that no unmatched couple both prefer each other to their partners under the matching.
  The stable marriage assignment problem was introduced by Gale and Shapley (1962)
  in the context of assigning applicants to colleges, taking into account the
  preferences of both the applicants and the colleges.

  The roommates problem is essentially a version of the stable marriage problem
  involving just one set. Each item in the set ranks the \emph{n} - 1 others in
  order of preference. The object is to find a stable matching, which is a
  partition of the set into pairs of roommates such that no two items
  which are not roommates both prefer each other to their actual couples.

  In biogeography, pairs of co-distributed species are considered pointers to
  some underlying factor driving that particular pattern (either historical or ecological one).
  It seems then reasonable to recognize stable couples of species in the matrix of
  spatial affinity in order to capture its main structure of co-distribution.
  The bulk of strong links between species is expected to be included in the pool
  of stable pairs. So, the measures of affinity associated to that pool can
  be used to extract a cutoff value to differentiate strong from weak links
  relating to the data under analysis.

  The profile of \code{preferences} for each species are dictated by its respective row
  in the input matrix. Self-matchings are possible. Selfpreferences are coded along
  the main diagonal and can be set by the user through a numeric vector.
  Alternatively, different methods can be applied on the set of
  association scores bounded by \code{initselfpref}, namely 1) "two-means":
  splits the scores into two classes of magnitude through the standard k-means algorihtm.
  The selfpreference is obtained from the midpoint between both classes; 2) "mean":
  takes the mean from the sampled values; 3) "quantile": produces the sample
  quantile corresponding to the given probability \code{prob}; 4) "customized":
  the intial reference provided by \code{initselfpref} becomes the final setting.

  In dealing with symmetric matrices of affinity, there is a simple algorithm to find
  the stable matching (Rodrigues-Neto 2007). Let \emph{n} be a strictly positive integer. 
  Let A = \{1, 2, ..., \emph{n}\} be the set of items in a population. Find the pair of 
  elements (i, j) from A X A with the maximum (or minimum) score in the similarity (or dissimilarity)
  matrix. Match i with j and remove them from the population. Then repeat the procedure
  with the remaining population until no more items could be matched.
}
\value{
  This function returns a list with three components:
  \item{stpairs}{Integer indices corresponding to the stable couple for each element.
                  Remember that self-matchings may be also reported.}
  \item{valref}{Numeric vector. Spatial affinities associated to the selected pairs.}
  \item{valdiag}{Numeric vector. Values of used selfpreferences.}
}
\references{
  Gale D., Shapley L.S. 1962. \emph{College Admissions and the Stability of Marriage.}
  Amer. Math. Monthly 69: 9-15.

  Rodrigues-Neto J.A. 2007. \emph{Representing Roommates' Preferences with Symmetric
  Utilities.} Journal of Economic Theory 135(1): 545-550.
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\seealso{
  Quantiles are estimated by the \code{\link{quantile}} function provided by the \code{stats}
  package. The method "two-means" uses the function \code{\link{kmeans}} with its
  argument \code{centers} set to 2.
}
\examples{
  data(mayflynz)
  aux <- procdnpoint(mayflynz)
  mtx1 <- acsh(aux) # Construct the dissimilarity matrix between species sets of points.
  mtx2 <- toposimilar(aux) # Now, construct the similarity matrix
  st1 <- stablecouple(mtx1, similarity = FALSE) #Stable matchings under mtx1
  st2 <- stablecouple(mtx2) #Stable matchings under mtx2
  #Following, plots the same set of species along three parallel axes.
  plot(rep(1:3, each = 40), rep(1:40, 3), main = "STABLE MATCHINGS", axes = FALSE,
       ylab = "", xlab = "", pch = 19)
  mtext("Couplings induced by mtx1", side = 1, line = 1, at = 1.5)
  mtext("(dissimilarity matrix)", side = 1, line = 2, at = 1.5)
  mtext("Couplings induced by mtx2", side = 1, line = 1, at = 2.5)
  mtext("(similarity matrix)", side = 1, line = 2, at = 2.5)
  #Each matching is represented by a segment. Self-matchings are horizontal
  #line segments. Note that symmetry means identical behavior of the involved
  #pair of taxa along the profiles of stable couplings.
  segments(rep(1, 40), 1:40, rep(2, 40), st1$stpairs, col = 2, lwd = 2)
  segments(rep(2, 40), 1:40, rep(3, 40), st2$stpairs, col = 2, lwd = 2)
}
\keyword{methods}

