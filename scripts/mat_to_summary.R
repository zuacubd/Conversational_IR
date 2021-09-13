args <- commandArgs(TRUE)
#args = commandArgs(trailingOnly=TRUE)

#library(randomForest)


num_args <- length(args)
if (num_args<1) {
	stop("At least one argument must be supplied (input file).\n", call.=FALSE)
} else {
	coll <- args[1]
	rmodel <- args[2]
	topics <- args[3]
	dist <- args[4]
	rrank <- args[5]
	mat_filepart <- paste(coll, rmodel, topics, dist, rrank, sep="_")
}

round3 <- function(m_matrix, digit){
	round_matrix <- round(m_matrix, digit)
	round_matrix
}

root_dir <- 'output/eval'
algorithms <- c('randforests', 'svm', 'lambdamart', 'listnet')
na <- length(algorithms)

metrics <- c("map", "ndcg", "P_10")
header <- paste('collection', 'algorithm', 'map', 'ndcg', 'P_10', sep="\t")

output_filepath <- paste(root_dir, mat_filepart, sep="/")
cat(header, file=output_filepath, sep="\n")

for(algorithm in algorithms){

	mat_filename = paste(mat_filepart, algorithm, 'reranked.res.mat', sep="_")
	mat_filepath = paste(root_dir, mat_filename, sep='/')

	print (mat_filepath)

	line <- paste(mat_filepart, algorithm, sep="\t")
	
	dat <- read.table(mat_filepath, header=TRUE, sep="\t")
	dat_met <- dat[, c("requete", metrics)]
	
	for(met in metrics){
		m <- mean(dat_met[, c(met)])
		line <- paste(line, m, sep="\t")		
	}
	cat(line, file=output_filepath, sep="\n",append=TRUE)
}

