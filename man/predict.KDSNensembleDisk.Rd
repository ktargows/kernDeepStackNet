\name{predict.KDSNensembleDisk}
\alias{predict.KDSNensembleDisk}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Predict kernel deep stacking networks ensembles (experimental)
}
\description{
Predicts new data with a given kernel deep stacking network ensembles. The model is not stored in workspace, but on disk in temporary folder, where it has been created. The temporary file folder should be available in the working directory. Note that this function is still experimental.
}
\usage{
\method{predict}{KDSNensembleDisk}(object, newx, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{object}{
Object of class \code{KDSNensemble}. This object is generated with the function \code{\link{fitEnsembleKDSN}}.
}
\item{newx}{
New data design matrix, for which predictions are needed. Variables must be in the same order, as the original training data.
}
\item{\dots}{
Further arguments to \code{predict} function.
}
}
\details{
The data is put through all specified layers of the kernel deep stacking network. The weights are not random, but fixed at the values generated by the fitting process. Examples are given in the help page of \code{\link{fitEnsembleKDSN}}.
}
\value{
A prediction matrix will be returned. Each row corresponds to one observation and each column is another KDSN ensemble. 
}

%\references{
%}

%References in article: Number 4, 20, 25, 15

%@book{RBFfuncApprox,
% title={Radial Basis Functions, Multi-Variable Functional Interpolation and Adaptive Networks},
% author={D.S. Broomhead and David Lowe},
% year={1988},
% publisher={Controller HMSO, London}
%}


\author{
Thomas Welchowski \email{welchow@imbie.meb.uni-bonn.de}
}

\note{
Do not rename the temporary directory. Otherwise the model files will not be found.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{fitKDSN}}, \code{\link{fitEnsembleKDSN}}
}

%\examples{
%}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ models & regression }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line