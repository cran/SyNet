\name{acshgral}
\alias{acshgral}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Generalized ACSH score}
\description{                    
  Returns the ACSH score for some set of species of any cardinality. 
}
\usage{
acshgral(dotdata, species)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dotdata}{Object of class 'dotdata'}
  \item{species}{Vector of indices specifying the target group of species}
}
\details{
  This function generalizes the notion of the ACSH score for pairs of species. It 
  may consider simultaneously many elements from a pool of species. For a given universe
  of records, the overall ACSH averages the longest interspecific gap measured at each point. 
  The interspecific gap corresponds to the shortest distance between a single point and a
  given set of species points. 
  
  I have implemented a procedure of agglomerative hierarchical clustering based on this measure.
  I think that results are very promising in the context of marked spatial 
  point processes. This procedure advances on the classification problem stated by Mane et al. (2006). 
  Basically, the idea consists of iteratively merging two items into a larger inclusive
  cluster so that the generalized acsh score is minimal across the totality of feasible 
  merging scenarios.  
 }
\value{
  A single non-negative real number that denotes the cost (in terms of imaginary 
  spatial displacement) to achieve complete overlap between distributions. 
}
\references{ 
  Dos Santos D.A., Cuezzo M.G., Reynaga M.C., Dominguez E. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).

  Mane S., Kang J., Shekhar S., Srivastava J., Murray C., Pusey A. 2006. \emph{Identifying
  Clusters in Marked Spatial Point Processes: A Summary of Results.} Technical Report 
  06-006. Department of Computer Science and Engineering, University of Minnesota. 
}
\author{
  Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>
}
\seealso{
  The function \code{\link{acsh}} addresses pairwise comparisons between species
  point sets. 
}
\examples{
  data(mayflynz)
  procnz <- procdnpoint(mayflynz)
  nsp <- length(procnz$Label)
  testmt <- acsh(procnz) 
  # Following, we will produce a matrix of ACSH scores for pairs of species,
  # but now with the generalized form.
  calcmt <- matrix(0, nrow = nsp, ncol = nsp)
  for(i in 1:(nsp-1)) 
    for(j in (i+1):nsp)
      calcmt[i,j] <- acshgral(procnz, c(i, j)) 
  all(calcmt + t(calcmt) == testmt) 
  #The previous statement should be TRUE because the generalized ACSH 
  #corresponds to the standard pairwise ACSH when 
  #two species are submitted to the function "acshgral".
  ################
  ################
  # This code makes explicit the above idea of hierarchical clustering based on the minimization 
  # of the ACSH profile throughout the nested structure of groups formed during the merging process
  diag(testmt) <- Inf
  newdist <- matrix(-1, nsp, nsp)
  notation <- as.character(1:nsp)
  classes <- 1:nsp
  analyze <- array(TRUE, nsp)
  while(max(classes)!= 1) {
    aux <- which.min(testmt) 
    items <- sort(c(row(testmt)[aux], col(testmt)[aux]))
    #Update cluster structure and ACSH scores
    ngr <- which(classes \%in\% items)
    classes[ngr] <- items[1]
    notation[items[1]] <- paste("(", notation[items[1]], " ", notation[items[2]], ")", sep = "")
    newdist[items[1], items[2]] <- newdist[items[2], items[1]] <- testmt[aux]
    analyze[items[2]] <- FALSE
    testmt[items, ] <- testmt[, items] <- Inf
    for(i in which(analyze)) {
      ogr <- which(classes == classes[i])
      if(i == items[1]) next 
      testmt[items[1], i] <- testmt[i, items[1]] <- acshgral(procnz, c(ngr, ogr)) 
    }
  }
  #Plot the respective dendrogram
  tt <- max(newdist) + 1 
  newdist <- ifelse(newdist == -1, tt, newdist)
  plot(hclust(as.dist(newdist), method = "single"), label = procnz$Label, 
       cex = 0.7, xlab = "", ylab = "Generalized ACSH")
  #Display relationships into a parenthetical notation. You can track the indices of the species in the
  #leaves of the following dendrogram
  plot(hclust(as.dist(newdist), method = "single"))
  cat(notation[1])
}
\keyword{ methods }

