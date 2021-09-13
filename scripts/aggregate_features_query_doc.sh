#!/bin/bash
#SBATCH --job-name=aggregate_features_query_doc
#SBATCH --output=output/logs/aggregate_features_query_doc.log

source "./PARAMETERS.sh"


PYTHON_PROGRAM='/logiciels/python3.4/bin/python3.4'

FEATURES_PATH="output/features/"

COLLECTION="$collection_name""_""$model_name"
TOPICS="$topics_range"

OUTPUT_PATH="output/features_merged/"

INPUT_MATRIX="$OUTPUT_PATH$COLLECTION""_""$TOPICS.query_doc.ftr"


mkdir -p "$OUTPUT_PATH"

#find_features_command="find \"$FEATURES_PATH\" -name \"*$COLLECTION""_""$TOPICS.query_doc*.ftr\""

time "$PYTHON_PROGRAM" ../scripts/aggregate_query_doc_features.py "$INPUT_MATRIX" > "$OUTPUT_PATH$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr"
