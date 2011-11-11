\name{cleavogram}
\alias{cleavogram}
\title{Cleavogram}
\description{
  Using a graphical user interface (GUI) this function plots an interactive cleavogram, and 
  allows the search of connected groups of species under different scenarios of cohesiveness. 
}
\usage{cleavogram()}
\details{
  The cleavogram is a visual tool for exploring the structural changes in a sympatry
  network as the removal of intermediary species proceeds. See the referenced paper for more information.

  The main window has three panels. The upper left panel is the cohesiveness manager.
  Here, the values of the cohesiveness parameters can be specified. If connected dyads 
  are considered to be meaningful entities itself, keep transitivity to 0 and eccentricities set
  'NONE'. The lower left panel exhibits in real time the spatial expressions of
  the current selected branch of the cleavogram. The right panel holds the cleavogram.
  There are several buttons at the left of the cleavogram to change its general
  appearance.

  A left click on the cleavogram displays a contextual menu to copy/save the plot
  for further editing actions. The double right click opens a new window to better
  explore the spatial expression associated to the target branch of the cleavogram. 
  If you press down the left hand mouse button, and while keeping it pressed you 
  move the mouse pointer throughout the cleavogram, branches are highlighted in 
  blue and the geographical panel refreshes accordingly.

  There is a combo box with a list of species (i.e. vertices of the network or leaves
  of the cleavogram) below the cleavogram panel. This enables to traverse the cleavogram from
  the root to the respective leaf, emphasizing the trajectory with a distinctive line. 
  This is a nice resource to see the distribution of sister taxa over the cleavogram.
  
  Menu Analysis allows to perform flat partitions following different search strategies.
  It also launches a visualizer of spatial expressions associated to a given flat partition.
}
\value{
  This function leaves the operating environment to allow the user access to the data.
  Flat partitions can be saved into an R object of class 'nampartition' provided of the next
  elements:
  \item{kind}{Character. Specifies the kind of spatial data either points or grids.}
  \item{status}{Two-columns data frame. Taxa names are located at the first column.
  The other column refers to the classification obtained after applying the flat partition.}
  \item{occupancy}{List of records by individual taxon.}
  \item{coords}{Two-column matrix. Values of the spatial coordinates associated to each
  record of the data set.}
}
\note{
  Once you have set the criteria of cohesiveness, make sure you have filtered the branches of the
  cleavogram satisfying those criteria. Go to menu Analysis and then Filter by criteria.
}
\references{
  Dos Santos D.A., Cuezzo M.G., Reynaga M.C., Dominguez E. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\seealso{
  \code{\link{nam}} creates objects of class \code{cleavogram} that can be
  opened by the menu Data --> Choose cleavogram ...
}
\examples{
  \dontrun{
  #NAM method applied on the example of New Zealand mayflies 
  data(mayflynz)
  dotdata <- procdnpoint(mayflynz)
  toposimilar(dotdata) -> toponz
  acsh(dotdata) -> acshnz
  reweight(toponz) -> toporew
  #The next step consists of obtaining the binary sympatry network, that is to
  #create the respective object of class 'dotinference'. This task can be done
  #interactively with function dotinfer.
  #Here, we will create the required 'dotinference' object by hand. The thresholding
  #rule match that used by Dos Santos et al. (2011).
  rslt <- c()
  rslt$sm <- ifelse(acshnz < 100 & toporew > 0.8, 1, 0)
  rslt$Label <- dotdata$Label
  rslt$occupancy <- dotdata$occupancy
  rslt$coords <- dotdata$coords
  rslt$kind <- "points"
  class(rslt) <- "dotinference"
  #Now, run NAM over the previous created object. Then go to the cleavogram and explore it. 
  outnz <- nam(rslt)
  cleavogram()
  }
}
\keyword{design}