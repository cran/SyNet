\name{selectpt}
\alias{selectpt}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Select a Flat Partition }
\description{
  Provides a listbox to select objects of class \code{nampartition} available at the 
  global environment. 
}
\usage{selectpt(entryPartition)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{entryPartition}{Entry text widget.}

}
\details{
  This function is auxilliary and is not intended to be called by the user. It 
  creates a GUI interface to select current objects of class \code{nampartition}.

  The global environment .GlobalEnv, more often known as the user's workspace, corresponds
  to the seacrh path. Thus, .GlobalEnv is the evaluation environment from which
  appropriate object names are taken. 
}

\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\seealso{ 
  \code{\link{cleavogram}} calls this function.
}
\keyword{ internal }

