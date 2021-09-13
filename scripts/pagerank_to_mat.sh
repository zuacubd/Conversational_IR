#!/bin/bash
#SBATCH --job-name=pagerank_to_mat
#SBATCH --output=output/logs/pagerank_to_mat.log

source "./PARAMETERS.sh"

PAGERANK_FILE_PRIOR="output/pagerank/$collection_name.pagerank.prior"
PAGERANK_FILE_RANKS="output/pagerank/$collection_name.pagerank.ranks"

name="$collection_name""_""$model_name"
OUTPUT_MATRIX_PRIOR="output/features/$name.pagerank_prior.ftr"
OUTPUT_MATRIX_RANKS="output/features/$name.pagerank_ranks.ftr"

time echo -e "doc_id\tpagerank_prior" >"$OUTPUT_MATRIX_PRIOR"; cat "$PAGERANK_FILE_PRIOR" | awk 'BEGIN{OFS="\t";}{$1=$1;print;}' >> "$OUTPUT_MATRIX_PRIOR"
time echo -e "doc_id\tpagerank_ranks" >"$OUTPUT_MATRIX_RANKS"; cat "$PAGERANK_FILE_RANKS" | awk 'BEGIN{OFS="\t";}{$1=$1;print;}' >> "$OUTPUT_MATRIX_RANKS"

