
## Compute the overlaps between two *numeric* lists:
numericListOverlap<- function(sample1, sample2, stepsize){
  n<- length(sample1)
  
  overlap<- function(a,b) {
    count<-as.integer(sum(as.numeric(sample1[1:a] %in% sample2[1:b])))    
	log.pval<- -phyper(q=count-1, m=a, n=n-a+1, k=b, lower.tail=FALSE, log.p=TRUE)         
    signs<- 1L
	    
    return(c(counts=count, 
             log.pval=as.numeric(log.pval),
			 signs=as.integer(signs)
             ))    
  }
  
  
  indexes<- expand.grid(i=seq(1,n,by=stepsize), j=seq(1,n,by=stepsize))
  overlaps<- apply(indexes, 1, function(x) overlap(x['i'], x['j']))
  
  nrows<- sqrt(ncol(overlaps))
  matrix.counts<- matrix(overlaps['counts',], ncol=nrows)  
  matrix.log.pvals<- matrix(overlaps['log.pval',], ncol=nrows)  
  matrix.signs<- matrix(overlaps['signs',], ncol=nrows)  
  
  return(list(counts=matrix.counts, log.pval=matrix.log.pvals))
}
### Testing:
# n<- 112
# sample1<- sample(n)
# sample2<- sample(n)  
# .test<- RRHO:::numericListOverlap(sample1, sample2, 10)
# dim(.test$log.oval)
# library(lattice)
# levelplot(.test$counts)
# levelplot(.test$log.pval)
# table(is.na(.test$log.pval))


