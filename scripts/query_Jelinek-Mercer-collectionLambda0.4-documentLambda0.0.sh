#!/bin/bash

#SBATCH --job-name=Jelinek-mercer-retrieval-indri
#SBATCH --output=logs/Jelinek-mercer-retrieval-indri.out
#SBATCH --error=logs/Jelinek-mercer-retrieval-indri.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=24CPUNodes
#SBATCH --mem-per-cpu=7800M

source "./PARAMETERS.sh"


runs_file_path="output/runs/$collection_name""_""Jelinek-Mercer-collectionLambda0.4-documentLambda0.0_$topics_range""_""indri.res"
mkdir -p `dirname $runs_file_path`

model="method:jm,collectionLambda:0.4,documentLambda:0.0"

echo "Indri retrieval based on jelinek mercer smoothing ... "
/projets/sig/mullah/ir/tools/query_indri/query_indri.sh -i "$indri_index" -v "$indri_version" -t "$train_queries_indri_lm" -r "$runs_file_path" -c "$documents_amount" -m "$model"
echo "Done."
