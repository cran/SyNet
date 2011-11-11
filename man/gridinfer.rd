\name{gridinfer}
\alias{gridinfer}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Sympatry Inference from Grids  }
\description{
  Produces a sympatry matrix from distributional data organized as tables of
  species vs. pre-defined spatial units.  
}
\usage{gridinfer(file = NULL, dntable = NULL, sp_row = TRUE, reciprocity = TRUE,
 criterion = "max", tolerance = sqrt(2), conditioned = TRUE, ...)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file}{Character string naming the ASCII file to read it. The file is read
  by \code{read.table} and contains an species-by-grids matrix of presence/absence. 
  Entries must be non-negative and scores higher than zero are interpreted as presence.}
  \item{dntable}{A matrix or data frame object with non-negative entries. It is 
  an species-by-grids distributional table. Entries must be non-negative and scores
  higher than zero are interpreted as presence. Indices or coordinates for each cell must 
  be arranged in the same table, preceding the species themselves} 
  \item{sp_row}{Logical. If \code{TRUE} rows are interpreted as species and columns as
  grids. If FALSE, the opposite is considered.} 
  \item{reciprocity}{Logical. If \code{TRUE}, comparisons between species ranges 
  are bidirectional.} 
  \item{criterion}{Character string. It should be a valid R function to extract a 
   summary statistic from a profile of proximities.}
  \item{tolerance}{Numeric. Represents the upper threshold to assess co-extensive sympatry.}
  \item{conditioned}{Logical. If \code{TRUE}, sympatry between taxa is subordinated to
  their co-occurrence in at least one cell.}
  \item{...}{Arguments to be passed to the function \code{\link{read.table}}}
}
\details{
  Species are sympatric if their ranges overlap, whereas they are allopatric
  if their ranges show spatial disjunction. Inference of sympatry can be addressed
  over raw distributional data (i. e., dot maps or coordinates of species records) or
  over distributional tables (i. e., tables of species vs. pre-defined areas that
  indicates occupancy or not).
  
  In case of punctual data, sympatry is inferred by the interaction of geographical
  proximity and interpenetration of species point sets. Thus, sympatry is proposed
  when records are close together, sharing an underlying area of unknown boundary. 
  In case of distributional data based on grids, sympatry is inferred by co-occurrence
  of species in pre-defined spatial unit (OGUs, operative geographical units).
  
  In the context of grids, the older version of SyNet considered two taxa sympatric  
  if they shared at least a single OGU of occurrence. This relaxed prescription has been
  changed now. 
  
  Each cell has assigned a pair of coordinates. They are the integer indices 
  of the row and column associated to that cell in the grid system. Then, given a pair of
  species, we calculate the nearest interspecific Euclidean distances among their OGUs. 
  If species A and B occupy OGUs \{1,2\} and \{3,4\}, respectively, we should obtain the 
  following vectors of distances.
  
  For species A:
  vecAB = \{min(\bold{d}(1,3), \bold{d}(1,4)), min(\bold{d}(2,3),\bold{d}(2,4))\}.
  
  For species B:
  vecBA = \{min(\bold{d}(3,1), \bold{d}(3,2)), min(\bold{d}(4,2),\bold{d}(4,3))\}.    
  
  In these statements, \bold{d} stands for Euclidean distance between a pair of OGUs.
  
  Inference of sympatry is based on the values found on the previous vectors of 
  proximity. Firstly, we need a summary or reference value for each vector, which is
  dictated by the above argument \code{criterion}. For example, under the default setting we
  obtain:
  
  refA = max(vecAB); refB = max(vecBA).
         
  Secondly, those reference statistics are compared against the upper threshold 
  indicated by the argument \code{tolerance}. Note that the default value, that is sqrt(2),
  is the maximal distance that contiguous cells may exhibit (corner-to-corner cells).
  
  Now, let suppose that refA < \code{tolerance}, but refB > \code{tolerance}. They 
  will pass the test of sympatry if the argument \code{reciprocity} would have been set FALSE.
  This scenario of asymmetry is expected for nested distributions. If you are interested
  on co-extensive sympatry, \code{reciprocity} should be set TRUE and sympatry statement 
  proceeds if both vectors are below the threshold. 
  
  Finally, the summary values derived from both vectors (e.g. vecAB, vecBA)
  may be lower than the threshold, despite the actual list of OGUs do not intersect. 
  In order to avoid considering sympatry when there is no co-occurrence,
  the argument \code{conditioned} acts preventively. So, if \code{conditioned}
  is TRUE, two species must inhabit a common OGU to be considered candidates 
  for sympatry. In this way, the default setting makes co-occurrence a
  necessary but not a sufficient condition to postulate meaningful sympatry between taxa.
 }
\value{
  An object of class \code{gridinference}, which is a list with components:
  \item{sm}{An adjacency matrix that reflects the existence (1) or
  not (0) of a sympatric link between species. }
  \item{occupancy}{List of OGUs occupied by species.}
  \item{coords}{Coordinates of each cell arranged into a two-columns matrix.}
  \item{kind }{Character. Specifies the kind of distributional data, that is "grids".}
}
\references{ 
  Dos Santos D.A., Fernandez H.R., Cuezzo M.G., Dominguez E.
  2008.\emph{ Sympatry Inference and Network Analysis in Biogeography.} 
  Systematic Biology 57:432-448.

  Dos Santos D.A., Cuezzo M.G., Reynaga M.C., Dominguez E. 2011. \emph{Towards a Dynamic
  Analysis of Weighted Networks in Biogeography.} Systematic Biology (in press).
}
\author{
  Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>
}
\note{
  Do not forget to provide the coordinates for the OGUs in the same input table, preceding 
  the species themselves. Thus, if species are rows then the first two rows are
  considered to have the coordinates of the OGUs, and similarly for species arranged into
  columns.  
}
\seealso{
  Objects of class \code{gridinference} can be submitted to the function \code{\link{nam}}.
}
\examples{
  data(sciobius2x2)
  #Do inference and discount reciprocity. 
  ######
  aux1 <- gridinfer(dntable = sciobius2x2, reciprocity = FALSE)$sm # Displays the sympatry matrix  
  #Check that the widespread S. pullus (pu) has here many neighbors because distributions
  #are nested inside it. In a network analysis this kind of element will behave as intermediary node.  
  aux1["pu",] #There are many connections to S. pullus coded 1. 
  ######
  #Do inference and force to consider reciprocity in the pairwise comparisons of species ranges. 
  #That is, study now co-extensive sympatry. 
  aux2 <- gridinfer(dntable = sciobius2x2, reciprocity = TRUE)$sm # Displays the sympatry matrix  
  #S. pullus is now an isolated node because there is no other taxa that spreads over the 
  #surface like S. pullus. 
  aux2["pu",] #Only the loop is present in this vector of connections for S. pullus.  
}
\keyword{methods}
