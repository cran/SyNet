outgrid <-
function(x, namx = NULL) {
if (is.null(class(x)) | class(x) != "gridinference") {
        cat("First argument is not of class 'gridinference' \n")
        return(invisible())
}
if (is.null(namx)) namx <- nam(x)
if (is.null(class(namx)) | class(namx) != "nam" | NROW(x$Dngrid) != NROW(namx$Categories)){
        cat("Incompatible arguments or inadequate class attribute of 2nd argument \n")
        return(invisible())
}
codenr <- as.integer(namx$Categories[,3])
numuc <- max(codenr)
if (numuc < 1){
  cat("No Unit of Co-occurrence. Meaningless obtain spatial expressions. \n")
  return(invisible())
}
labelgrid <- colnames(x$Dngrid)
spexpr <- vector("list", numuc)
vec_name <- array(dim = numuc)
for (i in 1:numuc) {
  spp <- which(codenr == i)
  grids <- (1:NCOL(x$Dngrid))[apply(x$Dngrid[spp,], 2, sum) > 0]
  spexpr[[i]] <- labelgrid[grids]
  vec_name[i] <- paste("UC ", i)
}
names(spexpr) <- vec_name
return(spexpr)
}
