\name{creategrid}
\alias{creategrid}
\title{Project Point Data into a Rectangular Mesh of OGUs}
\description{
  Dispalys punctual records into a grid system and creates the respective
  distributional table. Actions are facilitated by a graphical user interface (GUI).
}
\usage{creategrid(dnpoint)}
\arguments{
  \item{dnpoint}{An object of class 'dnpoint'.} 
}
\details{
  The grid parameters (cell size and upper leftmost corner) can be manually adjusted. 
  Keep press the left mouse button and move freely on the plotting region to select
  the upper leftmost corner.
  
  A choropleth of taxonomic richness is next to the graticule/gradicule under manipulation.
  A brief report of transformations (from points to grid) can be exported to a PDF file. 
}
\value{
  A data frame with species and rectangular OGUs (operative geographic units) 
  in rows and columns, respectively. The distributional table is saved into the 
  global environment. The presence of a taxon into a given cell of the grid is
  coded 1, otherwise 0. The coordinates for each cell or OGU are arranged into
  the first two rows of the table, preceding the species themselves. The coordinates
  are integer numbers and match the indices of rows and columns in the grid system. 
}
\references{
  Tobler W. 1975. \emph{Cellular geography.} Translation from the conference entitled 
  "Schachbrett Modelle in der Geographie" exposed at 
  "Arbeitskreis fur neue Methoden in der Regionalforschung", Wien.
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\note{
  Tobler (1975) is a good starting point to put the geographical reasoning based on 
  grids into an adequate context. Grids are appealing because of their isomorphism 
  with a matrix structure. Unfortunately, this simple method to deal with spatial data
  takes arbitrary decisions on features like shape, size and placement of cells over the surface. 
  Moreover, it is divorced from the spherical model of the Earth and forces distributions to 
  accommodate their extensions to the rectangular pattern of the grid. This last
  charge can be analogized with the Greek myth of Procrustes. 
  
  Procrustes lived near the city of Eleusis. He captured his victims and took them back
  to his iron bed and stretched them out until they fit. If the victim was too long,
  he would cut him off. In any case, he made them fit a pre-established frame. Theseus
  put an end to this obsession: he made the giant undergo the same 'normalizing' treatment. 
}
\seealso{See \code{\link{read.coord}} to capture point data from an external txt file}
\examples{
  data(mayflynz)
  \dontrun{
  creategrid(mayflynz)
  } 
}
\keyword{design}