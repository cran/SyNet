gridinfer <-
function (file = NULL, dntable = NULL, sp_row = TRUE){
  if(is.null(dntable)) dntable <- read.table(file, sep = ",")
  m <- as.matrix(dntable)
  if(sp_row) sm <- m%*%t(m) else {sm <- t(m)%*%m; dntable <- t(dntable)}
  sm <- (sm & sm)* 1
  out <- list(sm = sm, Label = rownames(dntable), Dngrid = dntable)
  class(out) <- "gridinference"
  out
}