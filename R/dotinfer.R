`dotinfer` <-
function(x) {
require(deldir)
if (is.null(class(x)) | class(x) != "dnpoint") {
        cat("Argument is not of class 'dnpoint' \n")
        return(invisible())
}
o <- order(x$Points[,2], x$Points[,3], x$Points[,1])
x$Points <- x$Points[o,]
numspecies <- max(x$Points[,1])
# Prepare a logical matrix of distribution. If there are duplicated points,
# they will be reduced to a single point later.
dntable <- matrix(FALSE, nrow=numspecies, ncol = x$Numpoints)
coordinates <- NULL
j <- 1
dntable[x$Points[j,1],j] <- TRUE
# The first column corresponds to longitude, the second to latitude.
# It is assumed that coordinates in class 'dnpoint' are provided in decimal format.
# Here, we convert them into radians.
coordinates <- rbind(c(x$Points[1, 2]*pi/180, x$Points[1, 3]*pi/180))
for (i in 2: x$Numpoints) {
  if ((x$Points[i,2] == x$Points[i-1,2]) & (x$Points[i,3] == x$Points[i-1,3])) {
    if (x$Points[i,1] != x$Points[i-1,1]) dntable[x$Points[i,1],j] <- TRUE
  }
  else {
    j <- j + 1; dntable[x$Points[i,1],j] <- TRUE; coordinates <- rbind(coordinates, c(x$Points[i,2]*pi/180, x$Points[i,3]*pi/180))
  }
}
# Delete superfluous columns
if (j < x$Numpoints) dntable <- dntable[,-((j+1) :x$Numpoints)]
numpoints <- j

# Pre-allocation of a geographical distance matrix. It is initialized to zero.
geodist <- matrix (0, ncol = numpoints, nrow = numpoints)
# Local function for calculating the great-circle distance between pairs of points.
# The radius used corresponds to the semi-major axis of WGS84 Datum.
Geographic_Distance <- function (lat1,  lat2, lng1, lng2) {
    angulo <- sin((lat2 - lat1) / 2) ^ 2 + cos(lat1) * cos(lat2) * sin((lng2 - lng1) / 2) ^ 2
    2 * atan(sqrt(angulo / (1 - angulo))) * 6378137 
}
for (i in 1:(numpoints - 1)) 
  for (j in (i + 1):numpoints) 
    geodist[i,j] <- geodist[j,i] <-  Geographic_Distance(coordinates[i,2], coordinates[j,2], coordinates[i,1], coordinates[j,1])


total_sp <- apply(dntable, 1, sum) # Number of non-duplicated points by species.
densities <- array(0, dim = numspecies) # Mean distance of separation between each point
                                        # and its nearest intra-specific neighbour. 
contrast_point <- array(Inf, dim = numpoints)
unique_sp <- NULL

# Variables 'referpt' and 'scanrd' will be used later to infer the Property II matrix 
referpt <- vector("list", numspecies) # Index of the natural apex of the   
                                      # the spherical cap contaning species
                                      # records. 
scanrd <- vector("list", numspecies)  # Distance between the natural apex and its farthest
                                      # intra-specific neighbour. 

# This loop may obtain values to be used in inference of both property I 
# and property II matrices.
for (i in 1:numspecies) {
  setpoint <- (1:numpoints)[dntable[i,]]
  a <- geodist[setpoint,setpoint]
  if (length(a)==1) {
    unique_sp <- c(unique_sp, i)
    referpt[[i]] <- setpoint[1]
    scanrd[[i]] <- 0
    contrast_point[setpoint[1]] <- 0
    next
  }
  for (j in 1:NROW(a)) {
    p <- min(a[j,-j])
    if (p < contrast_point[setpoint[j]]) contrast_point[setpoint[j]] <- p
    densities[i] <- densities[i] + p/total_sp[i] 
  }
  aux <- apply(a, 1, max)
  scanrd[[i]] <- min(aux)
  referpt[[i]] <- setpoint[which(aux == scanrd[[i]])]
}

# Compute the Delaunay Triangulation. For this, it is necessary the package 'deldir'.
triang <- deldir (coordinates[,1], coordinates[,2], frac = 0)
pairstr <- NROW(triang$delsgs)
dist_inter <- NULL # Length of triangulation segments obtained from geodist matrix
for (i in 1:pairstr)
 dist_inter <- c(dist_inter, geodist[triang$delsgs[i,5], triang$delsgs[i,6]])
# Toward the Reduced Delaunay Triangulation. Those segments to be deleted will be
# coded as 1, while segments to be conserved will be coded as 0. 
segcode <- array (0, dim = pairstr)
for (i in 1:pairstr) {
  # TRUE for intra-specific segments (also TRUE for ambiguous segments).
  a <- as.logical(dntable[,triang$delsgs[i,5]] * dntable[,triang$delsgs[i,6]])
  if (any(a)) {
    if (dist_inter[i] > 2*max(densities[a])) segcode[i] <- 1  
    next
  }
  # Stablish if inter-specific segments will be kept  
  minval <- min(c(contrast_point[triang$delsgs[i,5]],contrast_point[triang$delsgs[i,6]]))
  maxval <- max(c(contrast_point[triang$delsgs[i,5]],contrast_point[triang$delsgs[i,6]]))
  if (dist_inter[i] > (0.75*minval + 0.25*maxval)) segcode[i] <- 1
}
# Order from conserved (0) to deleted (1) segments.
o <- order(segcode)
segcode <- segcode[o]
triang$delsgs <- triang$delsgs[o,]
dist_inter <- dist_inter[o]
# Delete non-pertinent segments
for (i in 1:pairstr) {
  if (segcode[i] == 1) {
  dist_inter <- dist_inter[-(i:pairstr)]
  triang$delsgs <- triang$delsgs[-(i:pairstr),]
  break
  }
}

# Traverse the Reduced Delaunay Triangulation and discriminate components
adjacency <- vector ("list", triang$n.data)
ptocc <- vector ("list", triang$n.data) # Row index of triang$delsgs where a 
                                        # given point occurs
for (i in 1:triang$n.data) {
  ptocc[[i]] <- (1:nrow(triang$delsgs))[triang$delsgs[,5] == i | triang$delsgs[,6] == i]
  if (length(ptocc[[i]]) == 0) {ptocc[[i]] <- adjacency[[i]] <- 0; next}
  for (j in 1:length(ptocc[[i]])) {
    ifelse (triang$delsgs[ptocc[[i]][j],5] == i, 
            adjacency[[i]]<- c(adjacency[[i]], triang$delsgs[ptocc[[i]][j],6]), 
            adjacency[[i]] <- c(adjacency[[i]],triang$delsgs[ptocc[[i]][j],5]))
  }
}
# Obtain the property I matrix
propertyI <- matrix(0, ncol = numspecies, nrow = numspecies) # Create the Property I matrix 
analyzable <- array(TRUE, dim = triang$n.data)
# Do breadth_first_search to detect components
while(any(analyzable)) {
  cmp <- Q <- match (TRUE, analyzable)
  qpush <- 1
  analyzable [Q] <- FALSE
  if (adjacency[[Q]][1] == 0) { qpush <- 0 }
  while (qpush > 0) {
    v1 <- Q[1]
    for (i in 1:length(adjacency[[v1]])) {
      if (analyzable[adjacency[[v1]][i]]) {
        cmp <- c(cmp, adjacency[[v1]][i])
        Q <- c(Q, adjacency[[v1]][i]) 
        qpush <- qpush + 1
        analyzable[adjacency[[v1]][i]] <- FALSE
      }
    }
    Q <- Q[-1]
    qpush <- qpush - 1
  }# End of inner while
  aux <- (1:numspecies)[apply(as.matrix(dntable[,cmp]), 1, any)] 
  propertyI[aux, aux] <- 1
}

# Following, we will evaluate the interpenetration between sets of points. 
propertyII <- matrix(0, ncol = numspecies, nrow = numspecies)
diag(propertyII) <- 1
for (i in 1:(numspecies-1)) {
  for (j in (i+1):numspecies) {
    if(any(geodist[dntable[i,], referpt[[j]]] <= scanrd[[j]])) {
      propertyII[i,j] <- propertyII[j,i] <- 1
      next 
    }
    if(any(geodist[dntable[j,], referpt[[i]]] <= scanrd[[i]])) {
      propertyII[i,j] <- propertyII[j,i] <- 1 
    }
  }
}

# Finally, we obtain the consensus between propertyI and propertyII matrices.
hadamard <- (propertyI & propertyII)*1
diag(hadamard) <- 1
rslts <- list(sm = hadamard, Label = x$Label)
class(rslts) <- "dotinference"
rslts
}

