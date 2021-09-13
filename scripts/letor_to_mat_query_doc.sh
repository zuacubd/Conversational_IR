#!/bin/bash
#SBATCH --job-name=letor_to_mat_query_doc
#SBATCH --output=output/logs/letor_to_mat_query_doc.log

source "./PARAMETERS.sh"


PYTHON_PROGRAM='/logiciels/python3.4/bin/python3.4'

name="$collection_name""_""$model_name""_""$topics_range"

input_file_path="output/letor/$name""_""query-doc_terrier.letor"
output_file_path="output/features/$name.query_doc_features_terrier_letor.ftr"

time "$PYTHON_PROGRAM" /projets/sig/mullah/ir/tools/letor_tools/letor_to_mat.py -i "$input_file_path" | awk 'BEGIN{ FS=" "; OFS="\t"; }{$3 = ""; print}' | awk 'BEGIN{OFS="\t"}{$1=$1; print;}'  > "$output_file_path"
