library(kernDeepStackNet)
# Check function tune_KDSN (duration is long)
XORdat4Dim <- expand.grid(x1=c(0, 1), x2=c(0, 1), x3=c(0, 1), x4=c(0, 1))
XORdat4Dim <- cbind(y1=as.numeric(xor(xor(xor(XORdat4Dim[, 1], XORdat4Dim[, 2]), XORdat4Dim[, 3]), XORdat4Dim[, 4])), XORdat4Dim)
fittedKDSN <- fitKDSN(y=XORdat4Dim[, 1], X=as.matrix(XORdat4Dim[, -1]), levels=10)
predict(fittedKDSN, newx=as.matrix(XORdat4Dim[, -1]))

# Fit with standardized responses
fittedKDSN <- fitKDSN(y=XORdat4Dim[, 1], X=as.matrix(XORdat4Dim[, -1]), levels=100, standY=TRUE)
predict(fittedKDSN, newx=as.matrix(XORdat4Dim[, -1]))
