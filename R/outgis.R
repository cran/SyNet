`outgis` <-
function(x, dn, outfile = "namgis.txt") {
  if (is.null(class(x)) | class(x) != "nam") {
    cat("Argument is not of class 'nam' \n")
    return(invisible())
  }
  if (is.null(class(dn)) | class(dn) != "dnpoint") {
    cat("Argument is not of class 'dnpoint' \n")
    return(invisible())
  }
  if (!all(x$Categories[,1]==dn$Label)) {
    cat("Error: the label vectors of input arguments do not match \n")
    return(invisible())
  }
 
  # open an output file connection
  if (is.character(outfile)) 
        if (outfile == "namgis.txt") 
            zz <- file(outfile, "w")
        else {
            outfile <- paste(outfile, ".txt", sep ="")
            zz <- file(outfile, "w")
        }
       
  # put the names of fields 
  cat("LABEL", "LONGITUDE", "LATITUDE", "CODE", sep = ",", file = zz)
  for (i in 1:dn$Numpoints) {
  cat("\n", file = zz)
  cat(dn$Label[dn$Points[i,1]], dn$Points[i,2], dn$Points[i,3], x$Categories[dn$Points[i,1], 2], sep = ",", file = zz)
  }
  close(zz)
  cat("The generated file", outfile, " was located in the following path: ", "\n", getwd(), "\n")  
}

 
