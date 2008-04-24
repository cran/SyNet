\name{gridinfer}
\alias{gridinfer}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Sympatry Inference from Grids  }
\description{
  Produces a sympatry matrix from distributional data organized as tables of
  species vs. pre-defined spatial units.  
}
\usage{
  gridinfer(file = NULL, dntable = NULL, sp_row = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file}{Character string naming the ASCII file to read it. The file is read
  by \code{read.table} and contains an species-by-grids matrix of presence/absence. 
  Entries must be non-negative and scores higher than zero are interpreted as presence.}
  \item{dntable}{A matrix or data frame object with non-negative entries. It is 
  an species-by-grids distributional table. Entries must be non-negative and scores
  higher than zero are interpreted as presence.} 
  \item{sp_row}{Logical. If \code{TRUE} rows are interpreted as species and columns as
  grids, otherwise the opposite is considered.} 
}
\details{
  Species are sympatric if their ranges overlap, while they are allopatric
  if their ranges show spatial disjunction. Inference of sympatry can be addressed
  over raw distributional data (i. e., dot maps or coordinates of species records) or
  over distributional tables (i. e., tables of species vs. pre-defined areas that
  indicates occupancy or not).
  
  In case of punctual data, sympatry is inferred by the interaction of geographical
  proximity and interpenetration of sets of species records. Thus, sympatry is proposed
  when records are close together, sharing a subjacent area of unknown boundary. 
  A step by step explanation of the procedure can be found in the source code. 
  In case of distributional data based on grids, sympatry is inferred by co-occurrence
  of species in at least one pre-defined spatial unit. 
  
  The first approach uses the evidence of distribution without appealing 
  to \emph{a priori} delimited areas. It avoids the conversion of records into 
  ranges as a preliminar step to infer sympatry. 
  
  The second approach encodes the distribtuion of species in terms of area occupancy.
  It is prone to obtain results biased by the size (scale effect) and shape of
  spatial units considered. 
 }
\value{
  An object of class \code{gridinference}, which is a list with components:
  \item{sm}{An adjacency matrix that reflects the existence (1) or
  not (0) of a sympatric link between species. }
  \item{Label}{Character vector of species labels.}
  \item{Dngrid}{Distributional table of species-by-grids.}
  }
\references{ 
  Dos Santos, D.A., Fernandez, H.R., Cuezzo, M.G., Dominguez, E. \emph{Sympatry 
  Inference and Network Analysis in Biogeography.} Systematic Biology (in press).
}
\author{ Daniel A. Dos Santos }
\note{
  Given a distribuional matrix \bold{D}, where rows are species and columns grids,
  the sympatry matrix \bold{S} is firstly inferred through the matrix mulplication 
  of \bold{D} with its transpose. Then, entries are dichotomized, becoming \bold{S}
  in a binary matrix.   
}
\seealso{
  Objects of class \code{gridinference} can be submitted to functions \code{\link{outgrid}}
  and \code{\link{nam}}.
}
\examples{
data(sciobius2x2)
gridinfer(dntable = sciobius2x2)$sm # Displays the sympatry matrix  

}
\keyword{ methods }
