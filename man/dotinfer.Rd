\name{dotinfer}
\alias{dotinfer}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Inference of a Sympatry Network from Point Data}
\description{
  Using a Graphical User Interface (GUI), this function explores the pairwise relationships
  scored by weighted matrices of spatial association. It also helps to choose the cutoff
  value, creates an interactive network and plots intensity matrices. 
}
\usage{dotinfer(dotdata, mtxdata)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dotdata}{Object of class 'dotdata'.}
  \item{mtxdata}{List of weighted matrices based on the previous data. 
  The names for each element of this list are considered as the identity labels of matrices.}
}
\details{
  The list of weighted matrices in addition to the list of involved taxa are loaded
  into two different combo boxes. It is very important to identify the right 
  nature of the data (i.e. dissimilarity/similarity). In similarity matrices there is 
  a direct relationship between their scores and the strength of association. On the contrary,
  in dissimilarity matrices there is an inverse relationship between their scores and the
  strength of association. 
  
  Once you have selected a given matrix of spatial association, its single linkage dendrogram is drawn. 
  On the other hand, after you choose a given focus species, its couples are decreasingly ordered
  by the strength of spatial association between them. The upper left panel shows the spatial distributions
  of species pairs under consideration. The current focus species is indicated
  through red dots, whereas the current couple is represented by blue dots.
  There are buttons to shift the couples of the focus species, thus the user can move from 
  more to less associated neighbors according to the values dictated by the matrix
  under analysis. 
  
  Thresholds are used to dichotomize a weighted matrix into a binary one. I know this
  procedure entails loss of information. In order to preserve the largest amount of information,
  the bottom right panel assists the user in this task. Thus, the strongest relationships found on
  the matrix are recovered using the notion of stable couples (Gale and Shapley 1962). 
  The stable matchings are assumed to be representative of the strongest links
  in the underlying weighted network. Then, the distribution of affinity scores across  
  the stable couples is estimated via kernel density estimates. The percentage under the 
  density curve can be used as objective guideline to select the cutoff value. 
    
  Two appealing features of this interface can be found at the Display menu :
  i) manipulations of VAT images and ii) interactive layout of the inferred sympatry network. 
  
  The VAT approach presents pairwise association information about the set of objects
  O = \{o_1, ..., o_n\} as a square digital image with n*n pixels, after the objects
  are suitably reordered so that the image is better able to highlight potential
  cluster structure. VAT operates on the matrix of association between items and 
  transforms each score into a value in the gray tone scale.   
  
  The network derived from thresholding is displayed in an interactive graph drawing
  facility. Here, nodes can be picked out and moved throughout the canvas (in addition to its incident edges). 
  The right click on a given node highlights the target node and its neighbors in 
  red and blue colors, respectively. 
 }
\value{
  An object of class 'dotinference' is created into the working environment. It is a 
  list with components:
  \item{sm}{An adjacency matrix that suggests (1) or not (0) the occurrence of
             a sympatric link between species.}
  \item{Label}{Character vector of species labels.}
  \item{occupancy}{List of records occupied by each species.}
  \item{coords}{Spatial coordinates for each record occurring in the data set. They 
  are arranged into a two columns matrix.}
  \item{kind}{Character. Specifies the kind of distributional data, that is "points".}
}
\references{ 
  Bezdek J.C., Hathaway R. 2002. \emph{VAT: A Tool for Visual Assessment of (Cluster)
  Tendency.} Proc. Int. Joint Conf. Neural Networks (IJCNN 2002): 2225-2230.

  Dos Santos D.A., Cuezzo M.G., Dominguez E., Reynaga M.C. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).

  Gale D., Shapley L. 1962. \emph{College Admissions and the Stability of Marriage.}
  Amer. Math. Month. 69:9-15. 
}
\author{Daniel A. Dos Santos, <dadossantos@csnat.unt.edu.ar>}
\note{
  Intensity matrices are produced with the VAT algorithm published by Bezdek and
  Hathaway (2002). 
  Certainly, improvements on the layout of the network need to be introduced. I 
  hope to work on that in the near future! 
}
\seealso{
  Objects of class 'dotdata' result from submitting raw punctual data
  to the function \code{\link{procdnpoint}}.
  Kernel density estimates are calculated with the \code{\link{density}} function.
  Stables couples are obtained with the standard arguments available at \code{\link{stablecouple}}.
}
\examples{
  data(mayflynz)
  aux <- procdnpoint(mayflynz) #Pre-processing of data
  toponz <- toposimilar(aux) #Similarity matrix. 
  acshnz <- acsh(aux) #Dissimilarity matrix. 
  rewnz <- reweight(toponz) #Similarity matrix. 
  #Explore the content of previous matrices in addition to the distributions
  #of involved species. 
  \dontrun{
  dotinfer(aux, list(toponz = toponz, acshnz = acshnz, rewnz = rewnz))
  } 
}
\keyword{methods}
