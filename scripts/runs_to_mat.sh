#!/bin/bash

source "./PARAMETERS.sh"

PYTHON_PROGRAM='/logiciels/Python-3.5.2/bin/python3.5'

RUNS_PATH="output/runs/"

COLLECTION="$collection_name"
TOPICS="$topics_range"

REFERENCE_RUN="output/runs/$collection_name""_""$model_name""_""$topics_range""_""terrier.res"

OUTPUT_MATRIX="output/features/$collection_name""_""$model_name""_""$topics_range.query_doc_scores.ftr"

echo "Start merging multipe runs ..."
#echo find "$RUNS_PATH" -name "$COLLECTION*$TOPICS*.res"

time find "$RUNS_PATH" -name "$COLLECTION*$TOPICS*.res" | "$PYTHON_PROGRAM" /projets/sig/mullah/ir/tools/trec_tools/runs_to_mat.py -c "$documents_amount" -r "$REFERENCE_RUN" | awk 'BEGIN{ OFS="\t"; }{ print; }' > "$OUTPUT_MATRIX"
echo "Done."
