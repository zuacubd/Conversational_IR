#!/bin/bash

#SBATCH --job-name=BM25-retrieval-indri
#SBATCH --output=logs/BM25-retrieval-indri.out
#SBATCH --error=logs/BM25-retrieval-indri.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=24CPUNodes
#SBATCH --mem-per-cpu=7800M

source "./PARAMETERS.sh"

runs_file_path="output/runs/$collection_name""_""BM25_$train_topics_range""_""indri.res"
mkdir -p `dirname $runs_file_path`

model="okapi"

echo "Indri retrieval based on BM25"
/projets/sig/mullah/ir/tools/query_indri/query_indri_baseline.sh -i "$indri_index" -v "$indri_version" -t "$train_queries_indri_baseline" -r "$runs_file_path" -c "$documents_amount" -m "$model"
echo "Done."
