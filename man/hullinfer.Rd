\name{hullinfer}
\alias{hullinfer}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Sympatry Inference from Convex Hulls }
\description{
  Realizes all pairwise comparisons of overlapping between species ranges encoded 
  as convex hulls.
}
\usage{
  hullinfer(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ An object of class \code{dnpoint}.}
}
\details{
  \code{\link[grDevices]{chull}} is used to obtain the convex hulls. \cr 
  The internal analysis of geometric overlap is carried out by the function \code{\link{overlaphull}}. 
}
\value{
  An object of class \code{hullinference}, which is a list with the following elements: 
  \item{sm}{An adjacency matrix that reflects the existence (1) or
  not (0) of a sympatric link between species. }
  \item{Label}{A character vector of species labels.}
  \item{HullVertex}{List of convex hulls by species. Each main element shows the 
  \code{x} and \code{y} coordinates of points lying on the convex hulls, in clockwise
  order.}
}
\author{ Daniel A. Dos Santos }
\examples{
#####
# We create an object of class 'dnpoint' that includes many degeneracies
IDsp <- c(1,1,2,2,3,3,3,4,4,4,4,5,5,5)
Longitud <- c(1,1,3,3,0,4,5.5,1,1,2,2,1.5,3.5,3.5)
Latitud <- c(5,8,0,2,1,7,0,4,9,4,6,2,2,3)
Label <- c("A", "B", "C", "D", "E")
example <- list(Numpoints = 14, Points = data.frame(IDsp = IDsp,
           Longitud = Longitud, Latitud = Latitud), Label = Label)
class(example) <- "dnpoint"
rslt <- hullinfer(example)

#####
# Draw ranges
plot(Longitud, Latitud)
for (i in 1:5) 
  polygon(rslt$HullVertex[[i]], border = i) 

}
\keyword{ methods }

