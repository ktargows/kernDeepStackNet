\name{lossCvKDSN}
\alias{lossCvKDSN}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Kernel deep stacking network loss function based on cross-validation
}
\description{
Computes the average root mean squared error by cross-validation. The model is fitted \code{length(cvIndex)} times and predicts the left out test cases. This procedure may be repeated to decrease the variance of the average predictive deviance. The repetitions are assumed to be included in the list \code{cvIndex}. The format can be conviniently created by using supplied functions in the package \code{caret}, e. g. \code{\link[caret]{createFolds}}.
}
\usage{
lossCvKDSN(parOpt, y, X, levels, cvIndex, seedW=NULL, lossFunc=devStandard,
varSelect=rep(FALSE, levels), varRanking=NULL, alpha=rep(0, levels),
dropHidden=rep(FALSE, levels), seedDrop=NULL, standX=TRUE, standY=FALSE,
namesParOpt=rep(c("dim", "sigma", "lambdaRel"), levels))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{parOpt}{
The numeric parameter vector of the tuning parameters. The length of the vector is required to be divisible with three without rest. The order of the parameters is (D, sigma, lambda) in one level. Each additional level is added as new elements, e.g. with two levels (D_1, sigma_1, lambda_1, D_2, sigma_2, lambda_2), etc.
}
  \item{y}{
Numeric response vector of the outcome. Should be formated as a one column matrix.
}
  \item{X}{
Numeric design matrix of the covariates. All factors have to be prior encoded.
}
\item{levels}{
  Number of levels of the kernel deep stacking network (integer scalar).
}
  \item{cvIndex}{
List of training indices. Each list gives one drawn training set indices. See for example function \code{\link[caret]{createMultiFolds}}.
}
  \item{seedW}{
Seeds for the random Fourier transformation (integer vector). Each value corresponds to the seed of one level. The length must equal the number of levels of the kernel deep stacking network.
}
  \item{lossFunc}{
Specifies the used loss function for evaluation on the test observations. It must have arguments "preds" (predictions) and "ytest" (test observations). Default=devStandard is predictive deviance.
}
\item{varSelect}{
Should unimportant variables be excluded in each level? Default is that all available variables are used. (logical scalar)
}
\item{varRanking}{
Defines a variable ranking in increasing order. The first variable is least important and the last is the most important. (integer vector)
}
\item{alpha}{
Weight parameter between lasso and ridge penalty (numeric vector) of each level. Default=0 corresponds to ridge penalty and 1 equals lasso.
}
\item{dropHidden}{
Should dropout be applied on the random Fourier transformation? Each entry corresponds to the one level. Default is without dropout (logical vector).
}
\item{seedDrop}{
Specifies the seed of the random dropouts in the calculation of random Fourier transformation per level. Default is random (integer vector).
}
\item{standX}{
Should the design matrix be standardized by median and median absolute deviation? Default is TRUE.
}
\item{standY}{
Should the response be standardized by median and median absolute deviation? Default is FALSE.
}
\item{namesParOpt}{
Gives the names of the argument parOpt (character vector). It is used to encode the parameters into the correct structure suitable in fitting the kernel deep stacking network.
}
}
\details{
\code{namesParOpt}: \\
"select" corresponds to the relative frequency of dropping unimportant variables according to the randomized dependence coefficient. \\
"dim" corresponds to a dimension parameter of the random Fourier transformation. \\
"sigma" corresponds to the precision parameter of the gaussian distribution to generate random weights. \\
"dropProb" corresponds to probability of dropping out cells in the calculated random Fourier transformation matrix. \\
"lambdaRel" corresponds to the regularization parameter of kernel ridge regression.
}
\value{
Root average predictive deviance of the model (numeric scalar). The fit is available as attribute.
}
\references{
Po-Seng Huang and Li Deng and Mark Hasegawa-Johnson and Xiaodong He, (2013), 
\emph{Random Features for kernel deep convex network},
Proceedings IEEE International Conference on Acoustics, Speech, and 
Signal Processing (ICASSP)

Simon N. Wood, (2006), 
\emph{Generalized Additive Models: An Introduction with R},
Taylor \& Francis Group LLC
}

\author{
Thomas Welchowski \email{welchow@imbie.meb.uni-bonn.de}
}

\note{
Should only be used by experienced users, who want to customize the model. 
It is called in the model selection process of the kernel deep stacking network, e. g. \code{\link{tuneMboLevelCvKDSN}}
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{lossApprox}}, \code{\link{lossGCV}}, \code{\link{lossSharedCvKDSN}}, 
\code{\link{lossSharedTestKDSN}}
}

\examples{
####################################
# Example with simple binary outcome

# Generate covariate matrix
sampleSize <- 100
X <- matrix(0, nrow=100, ncol=10)
for(j in 1:10) {
  set.seed (j)
  X [, j] <- rnorm(sampleSize)
}

# Generate response of binary problem with sum(X) > 0 -> 1 and 0 elsewhere
# with Gaussian noise
set.seed(-1)
error <- rnorm (100)
y <- ifelse((rowSums(X) + error) > 0, 1, 0)

# Draw random test sets
library(caret)
Indices <- createMultiFolds(y=y, k = 10, times = 5)

# Calculate loss function with parameters (D=10, sigma=1, lambda=0)
# in one level
calcLoss <- lossCvKDSN(parOpt=c(10, 1, 0), y=y, X=X, 
cvIndex=Indices, seedW=0, levels=1)
c(calcLoss)

# Calculate loss function with parameters 
# (D=10, sigma=1, lambda=0.1, D=5, sigma=2, lambda=0.01) in two levels
calcLoss <- lossCvKDSN(parOpt=c(10, 1, 0.1, 5, 2, 0.01), 
y=y, X=X, cvIndex=Indices, seedW=1:2, levels=2)
c(calcLoss)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ models & regression }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line