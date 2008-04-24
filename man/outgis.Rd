\name{outgis}
\alias{outgis}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Generating Files for GIS Softwares }
\description{
  Generates a .txt file that can be imported by GIS softwares (e.g. DIVA-GIS)
  in order to convert the data in a shapefile of points.   
}
\usage{
  outgis(x, dn, outfile = "namgis.txt")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ Objetc of class 'nam'. }
  \item{dn}{ Object of class 'dnpoint'. }
  \item{outfile}{ A character string naming the .txt file to write to.  }
}
\details{
  The generated file has four fields separated by comma: Species Label, Longitude,
  Latitude and NAM Status. The first line of file contains the field labels. From
  second line on, respective field information.  
}
\author{ Daniel A. Dos Santos }
\note{ 
  DIVA-GIS is a free software widely used in biogeographical research. For DIVA-GIS
  users, the generated .txt file can be opened from menu DATA -> IMPORT POINTS TO SHAPEFILE
  -> FROM TEXT FILE (.TXT). 
}
\seealso{
  The homepage of DIVA-GIS is at \url{http://www.diva-gis.org/}.\cr
  Function \code{\link{nam}} for generating objects of 'nam' class.\cr 
  Function \code{\link{read.coord}} for reading records and generating objects of 
  class \code{'dnpoint'}.
}
\examples{
data(epiphragmophora)
p <- dotinfer(epiphragmophora)
x <- nam(p)
outgis(x, epiphragmophora) ##See the file in the working directory
}
\keyword{ file }

