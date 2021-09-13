#!/bin/bash

#SBATCH --job-name=TFIDF-retrieval-indri
#SBATCH --output=logs/TFIDF-retrieval-indri.out
#SBATCH --error=logs/TFIDF-retrieval-indri.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=24CPUNodes
#SBATCH --mem-per-cpu=7800M

source "./PARAMETERS.sh"

runs_file_path="output/runs/$collection_name""_""TFIDF_$train_topics_range""_""indri.res"
mkdir -p `dirname $runs_file_path`

model="tfidf"

echo "Indri retrieval based on TFIDF"
/projets/sig/mullah/ir/tools/query_indri/query_indri_baseline.sh -i "$indri_index" -v "$indri_version" -t "$train_queries_indri_baseline" -r "$runs_file_path" -c "$documents_amount" -m "$model"
echo "Done."
