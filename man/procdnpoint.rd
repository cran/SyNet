\name{procdnpoint}
\alias{procdnpoint}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Pre-processing of Raw Point Data}
\description{
   Transforms raw data of point distributions into formats appropriate for ulterior
   analysis. Please, see the details section for the different tasks that this 
   function performs. 
}
\usage{procdnpoint(dnpoint, tolerance = 1e-03)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dnpoint}{The object 'dnpoint' to be pre-processed.} 
  \item{tolerance}{A value specifying the maximal distance to consider any point 
                   of the data set to be 'close enough' to the known or observed
                   records of each species.} 
}
\details{
   The structure of data is firstly polished in removing duplicated points. Three main tasks
   are then developed: 
   
   1) Distance calculations. Two matrices are produced: (i) points X points,
   and (ii) species X points. Great circle or Euclidean distances are calculated 
   if the coordinate system is geographical or rectangular, respectively. The second
   matrix of species X points corresponds to the Hausdorff distance between any 
   single point of the data and the set of observed points for each species. 
   
   2) Data organization. A Boolean table accounts for the real species distributions. 
   Here, species are the rows whereas the universe of unique records is arranged into columns. 
   Although it is redundant, a list of species occurrences is also created. This list
   enables us to include additional points for each species if those extra points are
   separated from the observed/known points by a negligible distance. The parameter 
   \code{tolerance} dictates the criterion to consider a spatial gap between 
   records as negligible. 
   
   The argument \code{tolerance} is assumed to be in kilometers for the geographical
   coordinate system. Eventually, negative values are converted to absolute ones. 
   You can pass a numeric vector specifying the tolerance radius for each point
   of the data set. If the length of the vector \code{tolerance} differs 
   from the number of points indicated by the input object, then its values are 
   recycled through \code{rep} function until they reach the required length.
   Finally, if different tolerance values are set to the same point because
   there are different species occurring on it, then we arbitrarily
   consider the corresponding value in lexicographic order.  
   
   3) Minimum spanning tree report. For each species, a full report about its MST is
   provided (i.e. total length, endvertices of MST arcs, normalized weight for each point
   proportional to the mean length of its incident MST arcs).
}
\value{
  An object of class \code{dotdata}, which is a list with elements:
  \item{Call }{All arguments passed to this function when it was called.}
  \item{Label}{Character vector giving the labels for each species.}
  \item{dntable}{Boolean distributional table of species by records.}
  \item{Occupancy}{List of sampled records by species. Additional points falling in the 
                   tolerance radius around observed points are also included.}
  \item{Coords}{Two-columns table with (Longitude, Latitude)/(x, y) coordinates for
                the repository of unique points found throughout the data set.}
  
  \item{MSTsp}{List with data about the minimum spanning tree for each species.}

}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\seealso{ 
  Objects of class 'dnpoint' are created via \code{\link{read.coord}} from an input txt file
  of point coordinates. 
  The minimum spanning tree report is provided by \code{\link{mst}} 
}
\examples{
  #####
  # You can recognize the format of a typical input file
  # in the following created .txt:
  write(c("sp", "latitude", "longitude"), file= "proof.txt", ncolumns = 3, append = TRUE, sep = ",")
  # Sample 20 points from a normal distribution and segregate them into two sets equally sized. 
  x <- c(rnorm(10), rnorm(10, 2))
  y <- rnorm(20)
  for (i in 1:20) 
    write(c(LETTERS[ceiling(i/10)], x[i], y[i]),file= "proof.txt", 3, TRUE, sep = ",")
  # Put getwd() to identify the path where
  # the file 'proof.txt' has been located
  # Read the generated file.
  proof <- read.coord(inputfile = "proof.txt", type = "cartesian") 
  procdnpoint(proof) # Show the values returned by this function
  #####
  unlink("proof.txt") # Delete
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{file}

