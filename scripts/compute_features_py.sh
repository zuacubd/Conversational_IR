#!/bin/bash
#SBATCH --job-name=compute_features_py
#SBATCH --output=output/logs/compute_features_py.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=64CPUNodes

source "./PARAMETERS.sh"


python_program="/logiciels/python3.4/bin/python3.4"

name="$collection_name""_""$model_name""_""$topics_range"
output_path="output/features/"

index_type="$indri_version"


result_list="output/runs/$name""_""terrier.res"

#echo "starting"
time "$python_program" /projets/sig/smolina/public/Mesures_IR/eval_py/eval.py -n "$name" -o "$output_path" -t "$index_type" -i "$indri_index" -q "$topics_list" -r "$result_list" --results_per_query 1000 -f sum_idf_full mean_idf_full clarity sum_tf_full mean_tf_full sum_idf_full mean_idf_full sum_tf_idf_full mean_tf_idf_full


echo "starting"
#time "$python_program" /projets/sig/mullah/ir/tools/eval_py/eval.py -n "$name" -o "$output_path" -t "$index_type" -i "$indri_index" -q "$topics_list" -r "$result_list" --results_per_query 1000 -f sum_idf_full mean_idf_full clarity sum_tf_full mean_tf_full sum_idf_full mean_idf_full sum_tf_idf_full mean_tf_idf_full
