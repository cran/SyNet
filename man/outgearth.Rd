\name{outgearth}
\alias{outgearth}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Generate a KML File with Marked Set of Points }
\description{
  Produces Google Earth placemarks arranged into folders. Each folder consists of
  punctual records from a given group of species (i.e. a group detected 
  by the NAM method). 
}
\usage{outgearth(partition, showlabel = FALSE)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{partition}{ Object of class 'nampartition'. }
  \item{showlabel}{ Logical. TRUE means that labels will be added to the placemarks.}
}
\details{
 Visual properties for the entire set of records in each folder can be edited through 
 Google Earth options. For that, do no forget to click on the share style button.
}
\references{
  The Homepage of Google Earth is available at: \url{http://earth.google.com/}
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\seealso{
  Function \code{\link{cleavogram}} assists us for creating objects of class 
  \code{nampartition}. 
}
\examples{
  #This example is driven by a new idea of a sympatry network partitioning.
  #We will implement an algorithm based on the cliques found on the network and 
  #we will export the final classification into a KML file. 
  #######
  #Step 1: Infer the network of co-extensive sympatry in the Sciobius example:  
  data(sciobius2x2)
  aux <- gridinfer(dntable = sciobius2x2)
  #######
  #Step 2: Obtain the cliques
  cliques <- netproperties(aux$sm)$Cliques
  #######
  #Step 3: Perform the new alogrithm on the data frame of cliques (1/0 table of species
  #by cliques). Here, the maximum clique is selected and its members removed from the 
  #data frame. This task is repeated until no residual group can be extracted. 
  inc <- apply(cliques, 1, sum) #Number of cliques where a given species occurs
  flag <- sum(cliques)  
  i <- 1 #counter
  classes <- rep(NA, nrow(aux$sm))
  while(flag > 0){
    size <- apply(cliques, 2, sum) #Size of each clique
    clsel <- which.max(size) #Identify a single largest clique 
    members <- which(cliques[,clsel]==1)
    flag <- flag - sum(inc[members])
    inc[members] <- 0
    cliques[members,] <- 0 #Indirect way for removing species already classified
    classes[members] <- paste("Group ", i) 
    i <- i + 1
  }
  split(aux$Label, classes) #Print on R console the resulting partition
  #######
  #Step 3: Create an object of class nampartition by hand and . 
  rslt <- c()
  rslt$kind <- "grids"
  rslt$status <- cbind(Taxa = aux$Label, Status = classes)
  rslt$occupancy <- aux$occupancy
  #Next, set coordinates in function of the geographical centre for each cell used in the 
  #Sciobius' example
  rslt$coords <-  matrix(c(14, -20),  nrow = nrow(aux$coords), ncol = 2, byrow = TRUE) + 
                  matrix(c(2, -2), nrow = nrow(aux$coords), ncol = 2, byrow = TRUE)*aux$coords  
  class(rslt) <- "nampartition"
  #######
  #Step 4: Create the KML file
  \dontrun{
  outgearth(rslt) 
  #Save and then open the file with Google Earth. 
  }  
  #I think that this simple algorithm is worthy of refinement.
}
\keyword{file}
