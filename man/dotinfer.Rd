\name{dotinfer}
\alias{dotinfer}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Sympatry Inference from Records}
\description{
  Produces a sympatry matrix from available distributional data organized as a list
  of species records.  
}
\usage{
dotinfer(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Object of class 'dnpoint'}
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
  In case of grid based distributional data, sympatry is inferred by co-occurrence 
  of species in at least one pre-defined spatial unit. 
  
  The first approach uses the evidence of distribution without appealing 
  to \emph{a priori} delimited areas. It avoids conversion of records into 
  ranges as a preliminar step to infer sympatry. 
  
  The second approach encodes the distribtuion of species in terms of area occupancy.
  It is prone to obtain results biased by the size (scale effect) and shape of
  spatial units considered. 
 }
\value{
  An object of class 'dotinference' with components:
  \item{sm }{An adjacency matrix that reflects the existence (1) or
  not (0) of a sympatric link between species. }
  \item{Label }{Character vector of species label.}
  }
\references{ 
  Dos Santos, D.A., Fernandez, H.R., Cuezzo, M.G., Dominguez, E. \emph{Sympatry 
  Inference and Network Analysis in Biogeography.} Systematic Biology (in press).
}
\author{ Daniel A. Dos Santos }
\seealso{
  The package \code{deldir} is required to infer sympatry from punctual records.
}
\examples{
data(epiphragmophora)
dotinfer(epiphragmophora) # Infer the sympatry matrix.
}
\keyword{ methods }
