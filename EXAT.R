library(corpcor)

## Data (Example)
Phenotype <- c(1,1,0,1,0,0)

set.seed(1)

out_df <- data.frame(matrix(nrow=3,ncol=ncol(fixed)))

#loop through all instances
for (i in 1:ncol(fixed)){
  v1 <- as.integer(strsplit(fixed[i][1,],"[^0-9]+")[[1]])
  len <- length(v1)
  v1 <- v1[2:len]
  v2 <- as.integer(strsplit(fixed[i][2,],"[^0-9]+")[[1]])[2:len]
  v3 <- as.integer(strsplit(fixed[i][3,],"[^0-9]+")[[1]])[2:len]
  v4 <- as.integer(strsplit(fixed[i][4,],"[^0-9]+")[[1]])[2:len]
  v5 <- as.integer(strsplit(fixed[i][5,],"[^0-9]+")[[1]])[2:len]
  v6 <- as.integer(strsplit(fixed[i][6,],"[^0-9]+")[[1]])[2:len]
  gene <- data.frame(matrix(cbind(v1,v2,v3,v4,v5,v6),nrow=6,ncol=(len-1),byrow=TRUE))
  p1 <- perm.CMH.analysis(gene, Phenotype, permutationtime = 1000)
  p2 <- normal.CMH.analysis(gene, Phenotype, permutationtime = 50)
  name <- colnames(fixed[i])
  out_df[i] <- c(name,p1,p2)
}

write.csv(out_df,"C:\\Users\\andre\\OneDrive\\Desktop\\exat_data.csv",row.names = FALSE)

## Permutation test
#p1 <- perm.CMH.analysis(Genotype, Phenotype, permutationtime = 1000)
#p1

## Normal approximation 
#p2 <- normal.CMH.analysis(Genotype, Phenotype, permutationtime = 50)
#p2