\name{epiphragmophora}
\alias{epiphragmophora}
\docType{data}
\title{Epiphragmophora Distributional Data}
\description{
  Provides records of 21 species of the landsnail genus \emph{Epiphragmophora} consisting 
  of 145 coordinates in decimal format. 
}
\usage{data(epiphragmophora)}
\format{
  List of 3 elements:
   $ Numpoints: int 145
   $ Points   :'data.frame':	145 obs. of  3 variables:
   ..$ IDsp    : num [1:145] 1 1 1 1 1 1 1 1 1 1 ...
   ..$ Longitud: num [1:145] -65.5 -65.4 -65.3 -65.2 -65.4 ...
   ..$ Latitud : num [1:145] -26.8 -26.8 -26.7 -26.6 -26.8 ...
   $ Label    : chr [1:21] "argentina" "cryptomphala" "escoipensis" "guevarai" ...
   - attr(*, "class")= chr "dnpoint"
}
\details{
  Data were previously incorporated to an object of class 'dnpoint'.
}
\source{
  M. G. Cuezzo, curator of Malacological Collection of Miguel Lillo Museum,
  Tucuman, Argentina.  
}
\references{
  Cuezzo, M. G. 2006. \emph{Systematic revision and cladistic analysis of Epiphragmophora 
  Doering from Argentina and Southern Bolivia (Gastropoda: Stylommatophora: 
  Xanthonychidae)}. Malacologia 49:121-188.

  Dos Santos, D.A., Fernandez, H.R., Cuezzo, M.G., Dominguez, E. 2008. \emph{Sympatry
  Inference and Network Analysis in Biogeography}. Systematic Biology (in press). 
}
\examples{
data(epiphragmophora)
namep <- nam(dotinfer(epiphragmophora))

# Displays species labels belonging to each NAM Status category   
split(namep$Categories[,1], namep$Categories[,2]) 
                                       
}
\keyword{datasets}
