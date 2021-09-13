#!/bin/bash
#SBATCH --job-name=convert_ssv_to_tsv
#SBATCH --output=output/logs/convert_ssv_to_tsv.log

source "./PARAMETERS.sh"

FEATURES_PATH="output/features/"

COLLECTION="$collection_name""_""$model_name"
TOPICS="$topics_range"

INPUT_MATRIXS="$FEATURES_PATH/$COLLECTION""_""$TOPICS.*_py.ftr"
echo $INPUT_MATRIXS | head -n 1 | awk -F' ' '{for(i=1; i<=NF; i++) {system("cp "$i" "$i".tmp")}}'

echo "starting"

#awk 'BEGIN{FS=" "; OFS="\t";}{print;}' "$FEATURES_PATH""$COLLECTION""_""$TOPICS".doc_features_py.ftr.tmp > "$FEATURES_PATH""$COLLECTION""_""$TOPICS".doc_features_py.ftr
#awk 'BEGIN{FS=" "; OFS="\t";}{print;}' "$FEATURES_PATH""$COLLECTION""_""$TOPICS".query_features_py.ftr.tmp > "$FEATURES_PATH""$COLLECTION""_""$TOPICS".query_features_py.ftr
#awk 'BEGIN{FS=" "; OFS="\t";}{print;}' "$FEATURES_PATH""$COLLECTION""_""$TOPICS".query_doc_features_py.ftr.tmp > "$FEATURES_PATH""$COLLECTION""_""$TOPICS".query_doc_features_py.ftr

tr ' '  '\t' < "$FEATURES_PATH""$COLLECTION""_""$TOPICS".doc_features_py.ftr.tmp > "$FEATURES_PATH""$COLLECTION""_""$TOPICS".doc_features_py.ftr
tr ' ' '\t' < "$FEATURES_PATH""$COLLECTION""_""$TOPICS".query_features_py.ftr.tmp > "$FEATURES_PATH""$COLLECTION""_""$TOPICS".query_features_py.ftr
tr ' ' '\t' < "$FEATURES_PATH""$COLLECTION""_""$TOPICS".query_doc_features_py.ftr.tmp > "$FEATURES_PATH""$COLLECTION""_""$TOPICS".query_doc_features_py.ftr


echo "Done"

INPUT_MATRIXS="$FEATURES_PATH/$COLLECTION""_""$TOPICS.*_py.ftr.tmp"
echo $INPUT_MATRIXS | head -n 1 | awk -F' ' '{for(i=1; i<=NF; i++) {system("rm "$i)}}'
