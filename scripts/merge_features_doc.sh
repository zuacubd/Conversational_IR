#!/bin/bash
#SBATCH --job-name=merge_features_doc
#SBATCH --mail-type=END
#SBATCH --output=output/logs/merge_features_doc.log

source "./PARAMETERS.sh"


PYTHON_PROGRAM='/logiciels/Python-3.5.2/bin/python3.5'

FEATURES_PATH="output/features/"
COLLECTION="$collection_name""_""$model_name"
TOPICS="$topics_range"
OUTPUT_PATH="output/features_merged/"

OUTPUT_MATRIX="$OUTPUT_PATH/$COLLECTION""_""$TOPICS.doc.ftr"

mkdir -p "$OUTPUT_PATH"

find_features_command="find \"$FEATURES_PATH\" -name \"*$COLLECTION""_""$TOPICS.doc*.ftr\""

time bash -c "find \"$FEATURES_PATH\" -name \"$COLLECTION.pagerank_*.ftr\"; $find_features_command" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
