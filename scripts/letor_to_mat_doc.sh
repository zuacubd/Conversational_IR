#!/bin/bash
#SBATCH --job-name=letor_to_mat_doc
#SBATCH --output=output/logs/letor_to_mat_doc.log

source "./PARAMETERS.sh"

PYTHON_PROGRAM='/logiciels/python3.4/bin/python3.4'

name="$collection_name""_""$model_name""_""$topics_range"

input_file_path="output/letor/$name""_""doc_terrier.letor"
output_file_path="output/features/$name.doc_features_terrier_letor.ftr"


# Sort possible car doc id commence par WT dans cette collection
time "$PYTHON_PROGRAM" /projets/sig/mullah/ir/tools/letor_tools/letor_to_mat.py -i "$input_file_path" | awk 'BEGIN{ FS=" "; OFS="\t"; }{$1 = ""; $3 = ""; print}' | awk 'BEGIN{OFS="\t"}{$1=$1; print;}' > "$output_file_path"
