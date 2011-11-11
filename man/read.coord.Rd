\name{read.coord}
\alias{read.coord}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Read a List of Points from a txt File}
\description{
   Marked set of points are read from a given input file. Both geographical and Cartesian coordinates are accepted.  
}
\usage{read.coord(inputfile = "", type = "geographical")}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{inputfile}{Filename with complete path. By default, a Windows file dialog is open to choose the input file. } 
  \item{type}{A character string naming the coordinate system in which points have been referenced. 
              A partial matching is performed against these arguments: "geographical" and "cartesian".} 
}
\details{
  The input file should have three fields separated by commas. A header (i.e. first line)
  is required to differentiate latitude from longitude accurately. The first field
  must hold the species IDs. The second and third fields corresponds to the longitude
  and latitude indistinctly. 
  If points are derived from a Cartesian system of coordinates, longitude and latitude fields
  will be interpreted as the abscissa and ordinate respectively.
}
\value{
  An object of class \code{dnpoint}, which is a list with elements:
  \item{Numpoints }{Number of read points.}
  \item{Points}{Data frame with columns (1) indices for species, 
  (2) Longitude and (3) Latitude. Coordinates are in decimal format.}
  \item{Label}{Character vector of species labels.}
  \item{Type}{String specifying the type of coordinate system passed as argument.}
}
\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\examples{
  #####
  # You can recognize the format of a typical input file
  # in the following created .txt:
  write(c("sp", "latitude", "longitude"), file= "proof.txt", 3, TRUE, sep = ",")
  for (i in 1:10) 
    write(c(LETTERS[i], i*1.5, i*-8.6),file= "proof.txt", 3, TRUE, sep = ",")
  proof <- read.coord("proof.txt") # Put getwd() to identify the path where
                                   # the file 'proof.txt' has been located
  
  #####
  unlink("proof.txt") # Delete
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ file }

