#!/bin/bash

#SBATCH --job-name=Dirichlet-retrieval-indri
#SBATCH --output=logs/Dirichlet-retrieval-indri.out
#SBATCH --error=logs/Dirichlet-retrieval-indri.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=24CPUNodes
#SBATCH --mem-per-cpu=7800M

source "./PARAMETERS.sh"

runs_file_path="output/runs/$collection_name""_""Dirichlet-Mu1000_$train_topics_range""_""indri.res"
mkdir -p `dirname $runs_file_path`

model="method:dirichlet,mu:1000"

echo "Indri retrieval based on Dirichlet smoothing"
/projets/sig/mullah/ir/tools/query_indri/query_indri.sh -i "$indri_index" -v "$indri_version" -t "$train_queries_indri_lm" -r "$runs_file_path" -c "$documents_amount" -m "$model"
echo "Done."
