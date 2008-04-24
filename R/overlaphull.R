`overlaphull` <-
function (sp1, sp2) {
ns1 <- length(sp1$x)
pooled <- chull(c(sp1$x, sp2$x), c(sp1$y, sp2$y))
rslt <- pmatch(pooled, (1:ns1),nomatch = 0) 
if(all(rslt)|all(!rslt))
  return (1)
#Tests if there is any pair of segment that really intersect    
ns2 <- length(sp2$x)
sp1 <- list(x = c(sp1$x, sp1$x[1]), y = c(sp1$y, sp1$y[1]))
sp2 <- list(x = c(sp2$x, sp2$x[1]), y = c(sp2$y, sp2$y[1]))
for (i in 1:ns1){
  lx1 <- ly1 <- i
  hy1 <- hx1 <- i + 1
  if (sp1$x[i] > sp1$x[i+1]) {lx1 <- i + 1; hx1 <- i}
  if (sp1$y[i] > sp1$y[i+1]) {ly1 <- i + 1; hy1 <- i} 
  for (j in 1:ns2){
  lx2 <- ly2 <- j
  hx2 <- hy2 <- j + 1
  if (sp2$x[j] > sp2$x[j+1]) {lx2 <- j + 1; hx2 <- j}
  if (sp2$y[j] > sp2$y[j+1]) {ly2 <- j + 1; hy2 <- j}
   liej0 <- (sp1$x[i+1]-sp1$x[i])*(sp2$y[j]-sp1$y[i]) - (sp2$x[j]-sp1$x[i])*(sp1$y[i+1]-sp1$y[i]) 
   if (liej0 == 0)
    if (sp2$x[j] >= sp1$x[lx1] && sp2$x[j] <= sp1$x[hx1])
      if (sp2$y[j] >= sp1$y[ly1] && sp2$y[j] <= sp1$y[hy1])  return (1) 
   
   liej1 <- (sp1$x[i+1]-sp1$x[i])*(sp2$y[j+1]-sp1$y[i]) - (sp2$x[j+1]-sp1$x[i])*(sp1$y[i+1]-sp1$y[i]) 
   if (liej1 == 0)
    if (sp2$x[j+1] >= sp1$x[lx1] && sp2$x[j+1] <= sp1$x[hx1])
      if (sp2$y[j+1] >= sp1$y[ly1] && sp2$y[j+1] <= sp1$y[hy1])  return (1) 

  
   liei0 <- (sp2$x[j+1]-sp2$x[j])*(sp1$y[i]-sp2$y[j]) - (sp1$x[i]-sp2$x[j])*(sp2$y[j+1]-sp2$y[j]) 
   if (liei0 == 0)
    if (sp1$x[i] >= sp2$x[lx2] && sp1$x[i] <= sp2$x[hx2])
      if (sp1$y[i] >= sp2$y[ly2] && sp1$y[i] <= sp2$y[hy2])  return (1) 

   
   liei1 <- (sp2$x[j+1]-sp2$x[j])*(sp1$y[i+1]-sp2$y[j]) - (sp1$x[i+1]-sp2$x[j])*(sp2$y[j+1]-sp2$y[j])
   if (liei1 == 0)
    if (sp1$x[i+1] >= sp2$x[lx2] && sp1$x[i+1] <= sp2$x[hx2])
      if (sp1$y[i+1] >= sp2$y[ly2] && sp1$y[i+1] <= sp2$y[hy2])  return (1) 
   
   if ((liej0*liej1) < 0 && (liei0*liei1) < 0) return (1)
  }
 }
return (0)
}

