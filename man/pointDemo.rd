\name{pointDemo}
\alias{pointDemo}
\title{Interactive Assessment Demo of Affinity Between Dot Clouds }
\description{
  Using a graphical user interface (GUI), this function demonstrates the effects
  of changing the topology of dot clouds on the calculation of their strength of
  association. 
}
\usage{
  pointDemo()
}
\details{
  Two resources are used, a tcltk control window and a screen graphics device.
  In the first window, the user must specify the size of the dot clouds and
  can manipulate the layouts of point sets on the plotting area. 
  
  Once the "Draw!" button is pressed then the graphics device is waiting for the
  user to click and draw points. The length of the Euclidean minimum 
  spanning trees (MST) for each set of points is indicated. The length 
  of the MST associated to the joint set of points is also added. It is important
  to note how this last measure decreases as the dot clouds get close and interpenetrated. 
  Sympatry is suggested when the joint MST is equal or lesser than the sum of individual 
  MSTs (i.e. counter-synergic property).
}
\value{
  This function was designed for illustrating the procedure oriented to measure  
  the degree of association between dot clouds. Anyway, it prints a data frame
   into the R console specifying the coordinates for each plotted point. 
}
\author{
  Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>
}
\note{
  It seems impossible to measure sympatry between geographical entities without enclosing 
  records into areas. However, I think that the refinement of the idea underlying this game 
  can liberate us from the Procrustean nature of thinking distributions as bounded areas. 
}
\seealso{\code{\link{toposimilar}}}
\examples{
  \dontrun{pointDemo()}
}
\keyword{design}