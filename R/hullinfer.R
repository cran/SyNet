`hullinfer` <-
function(x) {
 # Geographical coordinates are considered as cartesian ones. This
 # is misleading and need to be performed.
  if (is.null(class(x)) | class(x) != "dnpoint") {
        cat("Argument is not of class 'dnpoint' \n")
        return(invisible())
      }
 # Pre-allocate an empty list of length = number-of-species
  nspecies <- length(x$Label)
  hv <- vector("list", nspecies)
 # Extract the vertices lying on the convex hull of each species
  for (i in 1:nspecies) {
    point <- (1:x$Numpoints)[x$Points[,1]==i]
    ptid <- chull(x$Points[point,2], x$Points[point,3])
    #Save the vertices in clockwise order
    hv[[i]] <- list(x = x$Points[point[ptid],2] , y = x$Points[point[ptid], 3])
  }
 # Infer the sympatry matrix by geometric overlap analysis of convex hulls
  sm <- matrix(0, nspecies, nspecies)
  diag(sm) <- 1
  for (i in 1:(nspecies-1)) 
    for (j in (i+1):nspecies){
    auxx <- range(c(hv[[i]]$x, hv[[j]]$x))
    auxy <- range(c(hv[[i]]$y, hv[[j]]$y))
    if((max(hv[[i]]$x) - min(hv[[i]]$x) + max(hv[[j]]$x) - min(hv[[j]]$x)) < (auxx[2] - auxx[1])) next
    if((max(hv[[i]]$y) - min(hv[[i]]$y) + max(hv[[j]]$y) - min(hv[[j]]$y)) < (auxy[2] - auxy[1])) next
    sm[i,j] <- sm[j,i] <- overlaphull(hv[[i]],hv[[j]])
    }
  out <- list(sm = sm, Label = x$Label, HullVertex = hv)
  class(out) <- "hullinference"
  out
}

