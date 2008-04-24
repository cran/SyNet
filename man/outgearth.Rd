\name{outgearth}
\alias{outgearth}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Generation of a KML File }
\description{
  Produces Google Earth placemarks from punctual species records.      
}
\usage{
outgearth(x, dn, outfile = "namgearth.kml")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Object \code{x} of class 'nam'. }
  \item{dn}{Object \code{dn} of class 'dnpoints'. }
  \item{outfile}{A character string naming the .kml file to write to.}
}
\details{
  The Homepage of Google Earth is available at: \url{http://earth.google.com/}
}
\references{
  A complete documentation about KML files are available at: 
  \url{http://code.google.com/apis/kml/documentation/kml_tut.html}
}
\author{ Daniel A. Dos Santos }
\examples{
data(epiphragmophora)
outnam <- nam(dotinfer(epiphragmophora))
outgearth(outnam, epiphragmophora, "proof") ## Find the file in the
                                            ## working directory 
}
\keyword{ file }

