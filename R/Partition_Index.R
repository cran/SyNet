`Partition_Index` <-
function (msym, n = NROW(msym)) {
# We put the diagonal elements equal zero to facilitate posterior calculations.
diag(msym) <- 0
Idx <- 0
coef <- array(0, n)
cperf <- array(0, n)
for (i in 1:n) {
  neigh <- (1:n)[msym[i,]==1]
  a <- length(neigh)
  if (a > 1) coef[i] <- sum(msym[neigh, neigh])/(a*(a-1))
}
for (i in 1:n) {
  neigh <- (1:n)[msym[i,]==1]
  a <- length(neigh)
  if (a > 0) cperf[i] <- min(coef[neigh])
  Idx <-  Idx + max(coef[i], cperf[i])
}
return(Idx/n)
}

