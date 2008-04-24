`read.coord` <-
function (inputfile = "") {
# Control commands to guarantee an adequate lecture of data 
if (substr(inputfile, nchar(inputfile, "chars") - 3,nchar(inputfile, "chars"))!= ".txt") {
  cat("The input file is not .txt \n")
  return(invisible())
} 
h <- scan(inputfile, sep = ",", what = character(0), nlines = 1)
if (length(h) != 3) {
  cat (c("Inadequate format of input file \n",  
   "Tip 1: Fields must be separated by comma \n",  
   "Tip 2: Include the following header: ID, Longitude, Latitude \n",  
   "Tip 3: The first field must correspond to your ID of species. The others have free order \n", 
   "Tip 4: Put coordinates in decimal format. \n"))
  return(invisible())
}
h <- tolower(h)
lo <- grep ("lo", h)
la <- grep ("la", h)
if (length(lo) != 1 | length(la) != 1) {
  cat(" No recognizable field identity. Verify that they are well written.  \n")  
  return(invisible())
} else if (la == lo) {
  cat(" No recognizable field identity. Verify that they are well written.  \n")  
  return(invisible())
}

if (any(c(lo, la) == 1)){
  cat (" Remember that the first field must be exclusive for the 'ID' one \n")
  return(invisible())
}
# Lecture of data
puntos <- scan(inputfile, sep = ",", what = list(character(0), double(0), double(0)), skip = 1)
numpoints <- length(puntos[[1]])
o <- order(puntos[[1]])
puntos[[1]] <- puntos[[1]][o]
puntos[[2]] <- puntos[[2]][o]
puntos[[3]] <- puntos[[3]][o]
if (any(is.na(puntos[[lo]])) | any(is.na(puntos[[la]]))){
  cat (" There are some lines wihtout coordinates associated to \n")
  return(invisible())
}
# Check if coordinates are inside the respective interval 
if (any(puntos[[lo]] > 180) | any(puntos[[lo]] <= -180)){
  cat (" There are some points with longitude out of range (-180,180] \n")
  return(invisible())
}
if (any(puntos[[la]] > 90) | any(puntos[[la]] < -90)){
  cat (" There are some points with latitude out of range [-90,90] \n")
  return(invisible())
}
codigo <- p <- puntos[[1]][1]
puntos[[1]][1] <- k <- 1
for (i in 2:numpoints) {
if (puntos[[1]][i] == p) puntos[[1]][i] <- k else {p <- puntos[[1]][i]; codigo <- c(codigo, p);
puntos[[1]][i] <- k <- k +1}
} 
rslts <- list (Numpoints = numpoints, Points = data.frame(cbind(IDsp = as.integer(puntos[[1]]), Longitud = as.double(puntos[[lo]]), Latitud = as.double(puntos[[la]]))), Label = codigo)
class(rslts) <- "dnpoint"
rslts
}

