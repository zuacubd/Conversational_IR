#!/bin/bash
#SBATCH --job-name=merge_features_query_doc
#SBATCH --output=output/logs/merge_features_query_doc.log

source "./PARAMETERS.sh"
TMPDIR="/users/sig/mullah/tmp"

PID="$$"

PYTHON_PROGRAM='/logiciels/Python-3.5.2/bin/python3.5'

FEATURES_PATH="output/features/"
COLLECTION="$collection_name""_""$model_name"
TOPICS="$topics_range"
OUTPUT_PATH="output/features_merged/"

OUTPUT_MATRIX="$OUTPUT_PATH/$COLLECTION""_""$TOPICS.query_doc.ftr"

mkdir -p "$OUTPUT_PATH"

#change it only for letor features
find_features_command="find \"$FEATURES_PATH\" -name \"*$COLLECTION""_""$TOPICS.query_doc_features_terrier_letor.ftr\""

time bash -c "$find_features_command" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 2  > "$OUTPUT_MATRIX"
echo "done."

echo "preparing headers ..."

head -n 1 "$OUTPUT_PATH/$COLLECTION""_""$TOPICS.doc.ftr" > "tmp/doc_features_header$PID"
head -n 1 "$OUTPUT_MATRIX" > "tmp/query_doc_features_header$PID"
echo "done"

echo "preparing tail ... "
tail -n +2 "$OUTPUT_PATH/$COLLECTION""_""$TOPICS.doc.ftr" | LANG=en_EN sort -T $TMPDIR -t $'\t' -k1 > "tmp/doc_features$PID"
tail -n +2 "$OUTPUT_MATRIX"  | LANG=en_EN sort -T $TMPDIR -t $'\t' -k2 > "tmp/query_doc_features$PID"
echo "done"

LANG=en_EN join -t$'\t' -1 2 -2 1 "tmp/query_doc_features_header$PID" "tmp/doc_features_header$PID" | awk 'BEGIN{OFS="\t"}{tmp=$2; $2=$1; $1=tmp; print $0;}' > "$OUTPUT_MATRIX"
LANG=en_EN join -t$'\t' -1 2 -2 1 "tmp/query_doc_features$PID" "tmp/doc_features$PID" | awk 'BEGIN{OFS="\t"}{tmp=$2; $2=$1; $1=tmp; print $0;}' >> "$OUTPUT_MATRIX"



rm "tmp/doc_features$PID" "tmp/query_doc_features$PID" "tmp/doc_features_header$PID" "tmp/query_doc_features_header$PID"
echo "done."
