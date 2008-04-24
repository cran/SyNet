\name{SyNet-package}
\alias{SyNet-package}
\alias{SyNet}
\docType{package}
\title{
  Inference and Analysis of Sympatry Networks
}
\description{
  Historical Biogeography focuses basically on sympatry patterns among species.
  \bold{SyNet} extracts hypotheses of sympatry from available distributional
  evidence and integrates them into sympatry networks. \bold{SyNet} tests the 
  adequacy of networks to be segregated into groups of species cohesively sympatric 
  (units of co-occurrence). It identifies units of co-occurrence from the more
  inclusive network where they are embedded. To do this, the program iteratively removes 
  intermediary species that connect the units to the general network. Data from 
  the spatial expressions of units are transferred to output files that can be 
  opened by GIS softwares and Google Earth.    
}
\details{
\tabular{ll}{
  Package: \tab SyNet\cr
  Type: \tab Package\cr
  Version: \tab 1.0\cr
  Date: \tab 2008-04-1\cr
  License: \tab GPL\cr
}
}
\author{ 
  Daniel A. Dos Santos
}
\references{
  Dos Santos, D.A., Fernandez, H.R., Cuezzo, M.G., Dominguez, E. \emph{Sympatry
  Inference and Network Analysis in Biogeogrpahy}. Systematic Biology (in press)
}
\seealso{
  Sympatry inference from dot maps uses Delaunay Triangulation on the set of 
  records considered. The package \code{deldir} is thus required to implement
  this action. \code{deldir} can be downloaded from the Comprehensive R Archive
  Network (\url{http://cran.r-project.org/}).
}
\examples{
data(sciobius2x2)

#####
# Derive a sympatry matrix. >=1 for co-occurrence in at least one location.
sm <- as.matrix(sciobius2x2)\%*\%t(as.matrix((sciobius2x2)))
# Plot a sympatry network
forgraph <- seq(0, by = 2*pi/47, length = 47)
xcoord <- cos(forgraph)
ycoord <- sin(forgraph)
par(mfrow = c(2,2))
plot(xcoord, ycoord, main = "Basal Sympatry Network", 
sub = "Non-significant Node Ordering", xlab = "", ylab = "")
text (xcoord*1.05, ycoord*1.05, rownames(sciobius2x2))
for (i in 1:46) 
  for (j in (i+1):47)
    if(sm[i,j] > 0) lines (c(xcoord[i], xcoord[j]), c(ycoord[i], ycoord[j]))
# The layout is sub-optimal, and it seems chaotic. But as Saramago says:
# 'Chaos is an order that has not been already decoded'.

#####
# Now, we order the nodes according to their NAM Status. 
namsc <- nam(gridinfer(dntable = sciobius2x2))
codenam <- as.integer(namsc$Categories[,3])
neworder <- order(codenam)
plot(xcoord, ycoord, main = "Basal Sympatry Network",
sub = "NAM Node Ordering", xlab = "", ylab = "" )
text (xcoord*1.05, ycoord*1.05, namsc$Categories[neworder,1])
for (i in 1:46) 
  for (j in (i+1):47) 
     if(sm[neworder[i],neworder[j]] > 0) 
       lines (c(xcoord[i], xcoord[j]), c(ycoord[i], ycoord[j]))
  
#####
# Finally, we delete links inciding on those nodes classified 
# as isolated or intermediary ones.
plot(xcoord, ycoord, main = "Selected Sub-network", 
sub = "Units of Co-occurrence", xlab = "", ylab = "" )
text (xcoord*1.05, ycoord*1.05, namsc$Categories[neworder,1])
for (i in 1:46){ 
  if (codenam[neworder[i]] < 1) next
  for (j in (i+1):47) {
    if (codenam[neworder[j]] < 1) 
      next
    if(sm[neworder[i],neworder[j]] > 0) 
      lines (c(xcoord[i], xcoord[j]), c(ycoord[i], ycoord[j]))
  }
}


}
\keyword{ package }