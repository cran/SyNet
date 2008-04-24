`track_OCP` <-
function (histrval, msym) {
# The function is implemented in an ugly form. 
#F eel free to suggest a better code.
OCPvalues <- 0
rsteps <- max(histrval)
n <- length(histrval)
if (NROW(msym) != n) {
  cat("Error: arguments passed to function track_OCP do not" + 
  " refer to the same number of species \n")
  return()
}
coefclu <- array(0, n)
cperf0 <- array(0, n)
cperf1 <- array(0, n)
asteps <- 1
track2 <- 0
selected <- 0
# To facilitate ulterior calculations
diag(msym) <- 0
for (i in 1:n) {
  neigh <- (1:n)[msym[i,]==1]
  a <- length(neigh)
  if (a > 1) coefclu[i] <- sum(msym[neigh, neigh])/(a*(a-1))
}
for (i in 1:n) {
  neigh <- (1:n)[msym[i,]==1]
  a <- length(neigh)
  if (a > 0) cperf0[i] <- min(coefclu[neigh])
}
while(asteps <= rsteps) {
  nodes <- (1:n)[histrval >= asteps]
  n1 <- length(nodes)
  aux <- msym[nodes,nodes]
  for (i in 1:n1) {
    neigh <- (1:n1)[aux[i,]==1]
    a <- length(neigh)
    if (a > 1) coefclu[nodes[i]] <- sum(aux[neigh, neigh])/(a*(a-1)) else coefclu[nodes[i]] <- 0
  }
  for (i in 1:n1) {
    neigh <- (1:n1)[aux[i,]==1]
    a <- length(neigh)
    if (a > 0) cperf1[nodes[i]] <- min(coefclu[nodes[neigh]]) else cperf1[nodes[i]] <- 0
  }
  track1 <- sum(cperf1[nodes]-cperf0[nodes])
  if (track1 >= track2) {track2 <- track1; selected <- asteps}  
  OCPvalues <- c(OCPvalues, track1)
  asteps <- asteps + 1
}
plot(c(0:rsteps), OCPvalues, ylab = "Overall Clustering Performance", 
     xlab = "Sub-Networks", pch = 19, main = "REMOVAL PROCESS \n (vertical line = selected sub-network)")
lines(c(0:rsteps), OCPvalues)
abline(v = selected, col = 2)
list(OCPvalues, selected)
}

