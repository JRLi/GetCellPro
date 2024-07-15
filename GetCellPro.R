#' Get Cell Proximity
#'
#' Calculates cell proximity metrics for given cell types and positions.
#'
#' @param pos_list A list of data frames with cell positions and types.
#' @param cel_typ A vector of cell types to be considered.
#' @param min_cell_number Minimum number of cells for a cell type to be considered (default is 10).
#' @param max_dis Maximum distance for proximity calculation (default is 100).
#' 
#' @return A data frame with proximity metrics.
#' 
#' @examples
#' # Example usage
#' pos_list <- list(
#'   sample1 = data.frame(posx = runif(1000, min = 5, max = 50), posy = runif(1000, min = 5, max = 50), dist.x = runif(1000, min = 5, max = 50), dist.y = runif(1000, min = 5, max = 50), cel.typ = sample(c("A", "B"), 50, replace = TRUE)),
#'   sample2 = data.frame(posx = runif(1000, min = 5, max = 50), posy = runif(1000, min = 5, max = 50), dist.x = runif(1000, min = 5, max = 50), dist.y = runif(1000, min = 5, max = 50), cel.typ = sample(c("A", "B"), 50, replace = TRUE))
#' )
#' cel_typ <- c("A", "B")
#' result <- GetCellPro(pos_list, cel_typ)
#' print(result)
#' 
#' @export
#' 
GetCellPro <- function(pos.List, cel.typ, min.cell.number = 10, max.dis=100){
  min.cell.number = min.cell.number
  maxs = max.dis*10
  cel.pair.name = outer(cel.typ, cel.typ, paste, sep="__")
  cel.pair.name = as.vector(t(cel.pair.name))
  cel.typ.num = length(cel.typ)
  nnk = 1
  mymat = matrix(0, cel.typ.num*cel.typ.num, length(pos.List))
  row.names(mymat) = cel.pair.name
  colnames(mymat) = names(pos.List)
  myList = pos.List
  for(ff in 1:length(myList)){
    cat("\r", ff)
    data = myList[[ff]]
    data = data[data$cel.typ%in%cel.typ,]
    data = data[se,]
    mylab = data$cel.typ
    xx = table(mylab)
    mynum = xx[cel.typ]
    mynum[is.na(mynum)] = 0
    
    myx = data$posx
    myy = data$posy
    tmpx = outer(myx, myx, "-")^2
    tmpy = outer(myy, myy, "-")^2
    dist = sqrt(tmpx+tmpy)
    diag(dist) = NA
    
    for(k in 1:cel.typ.num){
      mysta = cel.typ.num*(k-1)+1
      myend = cel.typ.num*k
      if(mynum[k]<min.cell.number){
        mymat[mysta:myend,ff] = NA
        next
      }
      se = which(mylab==cel.typ[k])
      dist.sub1 = dist[se,]
      for(i in 1:cel.typ.num){
        if(mynum[i]<min.cell.number){
          mymat[mysta+i-1,ff] = NA
          next
        }
        se = which(mylab==cel.typ[i])
        dist.sub2 = dist.sub1[, se]
        
        myvec = floor(apply(dist.sub2, 1, min, na.rm=T)*10)
        myvec = myvec[myvec<=maxs]
        tmp = table(myvec)
        xx = rep(0, maxs+1)
        xx[as.integer(names(tmp))+1]=tmp
        
        for(j in 2:(maxs+1)){
          xx[j] = xx[j-1]+xx[j]
        }
        mymat[mysta+i-1, ff] = sum(xx/max(xx))/(maxs+1)
      }
    }
  }
  df = as.data.frame(t(mymat))
  se = colnames(df)
  se = strsplit(se, '__')
  numerator = sapply(se,"[[",2)
  denominator = sapply(se,"[[",1)
  se = paste0(numerator,'→',denominator)
  colnames(df) = se
  return(df)
}

