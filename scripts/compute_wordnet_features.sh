#!/bin/bash
#SBATCH --job-name=compute_wordnet_features
#SBATCH --output=output/logs/compute_wordnet_features.log

source "./PARAMETERS.sh"

PYTHON_PROGRAM='/logiciels/Python-3.5.2/bin/python3.5'

FEATURES_OUTPUT_PATH="input/features_dorian"

mkdir -p "$FEATURES_OUTPUT_PATH"

time "$PYTHON_PROGRAM" ../scripts-wordnet/query_processor.py "$topics_list" -od "$FEATURES_OUTPUT_PATH"
