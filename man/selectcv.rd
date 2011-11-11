\name{selectcv}
\alias{selectcv}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Choice of a Cleavogram}
\description{
  Provides a listbox to select objects of class \code{cleavogram} available at the 
  global environment. 
}
\usage{selectcv(entryCleav)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{entryCleav}{Entry text widget.}
}
\details{
  This function is auxilliary and is not intended to be called by the user. It 
  creates a GUI interface to select current objects of class \code{cleavogram}.

  The global environment .GlobalEnv, more often known as the user's workspace, corresponds
  to the seacrh path. Thus, .GlobalEnv is the evaluation environment from which
  appropriate object names are included into the listbox. 
}

\author{Daniel A. Dos Santos <dadossantos@csnat.unt.edu.ar>}
\seealso{ 
  \code{\link{cleavogram}} calls this function.
}
\keyword{internal}

