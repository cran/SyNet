`outgearth` <-
function(x, dn, outfile = "namgearth.kml") {
  if (is.null(class(x)) | class(x) != "nam") {
        cat("Argument is not of class 'nam' \n")
        return(invisible())
  }
  if (is.null(class(dn)) | class(dn) != "dnpoint") {
        cat("Argument is not of class 'dnpoint' \n")
        return(invisible())
  }
  if (!all(x$Categories[,1]==dn$Label)) {
     cat("Error: label vectors of input arguments do not match\n")
     return(invisible())
  }
  
  # open an output file connection
  if (is.character(outfile)) 
        if (outfile == "namgearth.kml") 
            zz <- file(outfile, "w")
        else {
            outfile <- paste(outfile, ".kml", sep ="")
            zz <- file(outfile, "w")
        }
  
  # put the file header
  cat("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>", "<kml xmlns = \"http://earth.google.com/kml/2.0\">", "<Document>", sep = "\n", file = zz)
  # set the document name
  cat("   <name>", "From NAM to KML", "</name>\n", sep ="", file = zz)
  a <- "   <Placemark>\n       <name>"
  b <- "</name>\n       <Point>\n         <coordinates>"
  c <- ", 0</coordinates>\n      </Point>\n      <description><![CDATA["
  d <- "]]></description>\n   </Placemark>\n"
  for (i in 1:dn$Numpoints) {
    #create a placemark
    cat(a, x$Categories[dn$Points[i,1], 2], b, dn$Points[i,2], ", ", dn$Points[i,3], c ,dn$Label[dn$Points[i,1]], d, sep = "", file = zz)
  }
  #put the file footer
  cat("</Document>\n</kml>", file = zz)
  close(zz)
  cat("The generated file", outfile, "was located in the following path: ", "\n", getwd(), "\n")  
}

