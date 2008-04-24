`partition` <-
function (iptsymp, replica = 1) {
if(!is.matrix(iptsymp)) {cat("Error: the input argument is not a matrix \n"); return(invisible())} 
if(!isSymmetric(iptsymp)) {cat("Error: input matrix is not symmetric \n"); return(invisible())}
if((sum(iptsymp == 1) + sum(iptsymp== 0)) != NROW(iptsymp)^2) {cat("Error: input  matrix is not a binary one \n"); return(invisible())}
diag(iptsymp) <- 0
nodenr <- NROW(iptsymp)
pairs <- nodenr*(nodenr - 1)/2
probtie <- sum(iptsymp)/(2*pairs)
realval <- Partition_Index(iptsymp, nodenr)
if (replica==1) {cat("Partition Index of Sympatry Matrix: ", realval, "\n"); return(invisible(realval)) }
if (!is.integer(replica) | replica < 1 | replica > 5000) {cat("Error: the argument 'replicate' is not an integer or is excluded from [1,5000] \n"); return(invisible())}
rndval <- NULL
i <- 1
a <- 0 #number of replicates where real partition index is higher than random partition index
while (i <= replica) {
  rndmatrix <- matrix(0, nodenr, nodenr)
  for (k in 1:(nodenr-1))
  for (j in (k+1):nodenr){if (runif(1) <= probtie) {rndmatrix[k, j] <- rndmatrix[j,k] <- 1}}
  rndval <- c(rndval, Partition_Index (rndmatrix, nodenr))
  if (rndval[i] >= realval) a <- a + 1
  i <- i +1
}
hist(rndval, main= paste("RANDOM TEST \n", "N: ", replica , "; PI (p >= PI): ", round(realval, 3), "(",  round(a/replica, 3), ")"), xlab = "Partition Index (PI)", breaks = (0:40)*0.025, col = 1)
abline (v = realval, col = 2)
diag(iptsymp) <- 1
return (list(Input = iptsymp, ProbTie = probtie, NodeNr = nodenr, PIobserved = realval, PIrandomized = c(n = replica, mean = mean(rndval), sd = sd(rndval), min = min(rndval), max = max(rndval)), TestSign = round(a/replica, 5)))
}

