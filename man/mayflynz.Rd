\name{mayflynz}
\alias{mayflynz}
\docType{data}
\title{ Mayfly Fauna of New Zealand }
\description{
  List of 679 geographical records associated to the endemic fauna of mayflies in 
  the New Zealand archipelago. This data set belongs to the class \code{dnpoint}.
}
\usage{data(mayflynz)}
\format{
  The format is:
List of 4
 $ Numpoints: int 679
 $ Points   :'data.frame':	679 obs. of  3 variables:
  ..$ IDsp    : num [1:679] 1 1 1 1 1 1 1 1 1 1 ...
  ..$ Longitud: num [1:679] 175 175 175 175 175 ...
  ..$ Latitud : num [1:679] -41.2 -41.2 -41.2 -41.1 -40.9 ...
 $ Label    : chr [1:40] "Acanthophlebia cruentata" "Arachnocolus phillipsi" "Atalophlebiodes cromwelli" "Aupouriella pohei" ...
 $ Type     : chr "geographical"
 - attr(*, "class")= chr "dnpoint"
}
\details{
  Ephemeroptera (mayflies) are an ancient lineage of insects. Aquatic nymphs are
  the dominant life history stage. Adults have short lives ranging from a few hours to a few days.
  All species are endemic to this archipelago and their distribution patterns seem 
  to be driven by landscape changes associated to Pleistocene glaciations. Leptophlebiidae 
  and Nesameletidae are the most specious families and they have been considered 
  in compiling this data set.

  Localities given in New Zealand Map Grid projection metric coordinates were converted
  to the WGS84 datum with the online utility provided by the Land Information New Zealand
  government department (LINZ, \url{http://www.linz.govt.nz/}. Additional records
  for Zephlebia pirongia were inferred from its dot map in Hitchings (2008a).
  Random samples without replacement of  thirty percent of records previously extracted for 
  \emph{Z. pirongia} were assigned to its co generic homopatric species 
  \{\emph{Z. dentata, Z. nebulosa, Z. inconspicua, Z. versicolor}\} (Hitchings 2008a).
}
\source{
  Hitchings T.R., Staniczek A.H. 2003. \emph{Nesameletidae (Insecta: Ephemeroptera).}
  Fauna of New Zealand 46:1-72. Lincoln, New Zealand.
  
  Towns D.R., Peters W.L. 1996. \emph{Leptophlebiidae (Insecta: Ephemeroptera).}
  Fauna of New Zealand 36. Lincoln, New Zealand.
  
  Hitchings T.R. 2008a. \emph{The post glacial distribution of New Zealand mayflies.}
  In: Hauer F.R, Stanford J.A., Newell R.L., editors. International advances in 
  the ecology, zoogeography and systematics of mayflies and stoneflies. 
  Univ. Calif. Publ. Entomol. 128:89-101.
  
  Hitchings T.R. 2008b. \emph{A new species of Deleatidium (Penniketellum) and the 
  adult of D. (P.) cornutum Towns and Peters (Ephemeroptera: Leptophlebiidae) from New Zealand.}
  Rec. Canterbury Mus. 22:31-43. 

  Hitchings T.R. 2009a. \emph{Three new species of  Deleatidium (Deleatidium) 
  (Ephemeroptera: Leptophlebiidae) from New Zealand.} Rec. Canterbury Mus. 23: 35-50.
  
  Hitchings T.R. 2009b. \emph{Leptophlebiidae (Ephemeroptera) of the alpine region 
  of the Southern Alps, New Zealand.} Aquat. Insects 31(Supp. 1): 595-601.
  
  Winterbourn, M.J. 2009. \emph{A new genus and species of Leptophlebiidae (Ephemeroptera)
  from northern New Zealand.} N.Z. J. Zool. 36:423-430.
}
\references{
  Dos Santos D.A., Cuezzo M.G., Reynaga M.C., Dominguez E. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).
}
\examples{
data(mayflynz)
plot(mayflynz[[2]][,2:3], main = "Mayfly Fauna of New Zealand", xlab = "Latitude",
     ylab = "Longitude", asp = 1.3)
}
\keyword{datasets}
