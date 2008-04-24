`nam` <-
function(msym) {
if (!any(c("dotinference", "hullinference", "gridinference") == class(msym))) {
        cat("Verify that argument corresponds to some class of sympatry inference \n")
        return(invisible())
    }
sp_num <- NROW(msym$sm)
# Following, I translate to R language the C source code of Newman to calculating 
# the betweenness measure. His algorithm is available at:
# Newman, M. E. J. 2001. Scientific collaboration networks. II. Shortest paths,
# weighted networks and centrality. Phys. Rev. E 64:016132. 
betwns <- function( IDsp, edge_bet, degree) {
  if (degree[IDsp]==0) {total[IDsp] <<- 2; component[IDsp] <<- 1; return()}
  pred <- matrix (0, nrow = sp_num, ncol = sp_num)
  d <- array(-1, sp_num) #para saber si esta definido
  p <- array(0, sp_num)
  npred <- array(0, sp_num) #number of pred
  # Put the first vertex in the queue and set its distance to zero
  q <- IDsp
  qpush <- 1
  qpop <- 0
  d[IDsp]  <- 0
  p[IDsp] <- 1
  orden <- IDsp
  count <- 1
  # Main Loop
  while (qpush > qpop) {
     # Pull a vertex off the stack and calculate the distance for each
     # of its neighbors
     qpop <- qpop + 1
     v1 <- q[qpop]  #head of queue 
     d2 <- d[v1] + 1
     for (i in 1:degree[v1]) {
        if(!ignore[edge_bet[[v1]][i]]) {
        v2 <- edge_bet[[v1]][i]
        if (d[v2]== -1) {
          d[v2] <- d2
          p[v2] <- p[v1]
          npred[v2] <- npred[v2] + 1
          pred[v2, npred[v2]] <- v1
          q <- c(q, v2)
          qpush <- qpush + 1
          count <- count + 1
          orden <- c(orden, v2)
        }
        else if (d2 == d[v2]) {
          p[v2] <- p[v2] + p[v1]
          npred[v2] <- npred[v2] + 1
          pred[v2, npred[v2]] <- v1
        }
      }
    }
  }

# Now use the tree to calculate the number of shortest paths through
# each vertex.  We go through each vertex in the opposite order to the
# order they were added to the tree, i.e., starting from the farthest
# one and working towards the nearest.  This guarantees that the paths
# to the ones above you in the tree will always have been calculated already
# Everyone starts off with one path

  caminos <- array(0, sp_num)
  for (i in 1:count) caminos[orden[i]] <- 1
  # Main loop
  if (count > 1) {
   for (i in count:2) {
      v1 <- orden[i]
      for (j in 1:npred[v1]) {
        v2 <- pred[v1, j]
        caminos[v2] <- caminos[v2] + caminos[v1] * p[v2] / p[v1]
      }   
   }
  }
# And store the size of this component
  total[orden] <<- total[orden] + caminos[orden]
  component[IDsp] <<- count
}
# Pre-allocation
edge <- vector("list", sp_num)
degree <- array(0, sp_num)
diag(msym$sm) <- 0
for (i in 1:sp_num) {edge[[i]] <- (1:sp_num)[msym$sm[i,] > 0]; degree[i] <- length(edge[[i]])} 
density <- sum(degree)/(sp_num*(sp_num-1))
betscore <- NULL
nb <- NULL
recorded <- array(0, sp_num) # It indicates the most advanced sub-network at which 
                             # a node has been recorded.  
ignore <- array(FALSE, sp_num)
removal <- 0
while (1) {
  component <- array(0, sp_num)
  total <- array(1, sp_num)
  for (xp in 1:sp_num) {if(!ignore[xp]) betwns(xp, edge, degree)}
  bvector <- zapsmall (total/2 - component, digits = 8)
  bvector[ignore] <- -1 
  hb <- max(bvector) 
  if (hb > 0){
  betscore <- c(betscore, hb)
  sp <-  (1:sp_num)[bvector==hb]
  nb <- c(nb, sp)
  recorded[-nb] <- recorded[-nb] + 1 
  ignore[sp] <- TRUE
  } else break
}
# History of node membership is tracked out by an integer vector.
# Elements belong to the interval [0,n], being '0' the basal network and 'n'
# the last sub-network generated. 
# The nodes of basal network are those with entries >= 0, 
# nodes of sub-network 1 are those with entries >= 1 and so on. 
rmhistory <- track_OCP(recorded, msym$sm)
numunits <- 0
diads <- -1
code_sp <- array(0, sp_num)
analyzable <- as.logical(recorded >= rmhistory[[2]])  
while(any(analyzable)) {
  C <- Q <- match (TRUE, analyzable)
  qpush <- 1
  analyzable [Q] <- FALSE
  while (qpush > 0) {
    v1 <- Q[1]
    if (length(edge[[v1]]) == 0) {qpush <- 0 ; next}
    for (i in 1:length(edge[[v1]])) {
      if (analyzable[edge[[v1]][i]]) {
        C <- c(C, edge[[v1]][i])
        Q <- c(Q, edge[[v1]][i]) 
        qpush <- qpush + 1
        analyzable[edge[[v1]][i]] <- FALSE
        }
    }
    Q <- Q[-1]
    qpush <- qpush - 1
  } #end of inner while
  if (length(C) > 2) caso <- 3 else caso <- length(C)
  switch(caso, code_sp[C] <- -1, code_sp[C] <- diads <- diads -1, code_sp[C] <- numunits <- numunits + 1)
}
categ <- array(dim = sp_num)
mode(categ) <- "character"
for (i in 1:sp_num) {
  if (code_sp[i] < -1) categ[i] <- paste("Diad ", -1*(code_sp[i] + 1))
  else if (code_sp[i] == -1) categ[i] <- "Isolated" 
  else if (code_sp[i] == 0) categ[i] <- "Intermediary" else categ[i] <- paste("UC ", code_sp[i])
}
ctgr <- data.frame (cbind(msym$Label, categ, code_sp), stringsAsFactors = FALSE)
names(ctgr) <- c("Species", "NAM Status", "Internal Code")
rslts <- list(LastNet = recorded, Betweenness = betscore, OCPtrajectory = rmhistory[[1]], Selected = rmhistory[[2]], Categories = ctgr)
class(rslts) <- "nam"
rslts
} #end of function


