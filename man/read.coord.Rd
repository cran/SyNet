\name{read.coord}
\alias{read.coord}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Read a List of Coordinates }
\description{
   Organizes the distributional information about species. Data are provided as set
   of punctual records with latitude and longitude coordinates.  
}
\usage{
read.coord(inputfile = "")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{inputfile}{ A character string naming the .txt file to read it.} 
}
\details{
  The input file must contain three fields separated by comma. A header is necessary
  to identify latitude from longitude. The first field must correspond to the ID of 
  species. The second and third fields corresponds to longitude and latitude wihtout
  distinction of order priority. The rest of file corresponds to records.
}
\value{
  An object of class \code{dnpoint}, which is a list with elements:
  \item{Numpoints }{Number of read points.}
  \item{Points}{Data frame with columns (1) index of species, 
  (2) Longitude and (3) Latitude. Coordinates are in decimal format.}
  \item{Label}{Character vector of species labels.}
}
\author{ Daniel A. Dos Santos}
\seealso{ 
  Objects of class \code{dnpoint} are required by the functions \code{\link{dotinfer}},
  \code{\link{hullinfer}}, \code{\link{outgis}} and \code{\link{outgearth}}.
}
\examples{
#####
# You can recognize the format of a typical input file
# in the following created .txt:
write(c("sp", "latitude", "longitude"), file= "proof.txt", 3, TRUE, sep = ",")
for (i in 1:10) 
  write(c(LETTERS[i], i*1.5, i*-8.6),file= "proof.txt", 3, TRUE, sep = ",")
proof <- read.coord("proof.txt") # Put getwd() to identify path where
                                 # the file 'proof.txt' was located

#####
unlink("proof.txt") # Delete

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ file }

