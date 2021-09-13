#!/bin/bash

source "./PARAMETERS.sh"


PYTHON_PROGRAM='/logiciels/python3.4/bin/python3.4'

FEATURES_PATH="output/features/"
OUTPUT_PATH="output/features_merged/"

COLLECTION="$collection_name""_""$model_name"
TOPICS="$topics_range"

OUTPUT_MATRIX="$OUTPUT_PATH/$COLLECTION""_""$TOPICS.query.ftr"

mkdir -p "$OUTPUT_PATH"

#find_features_command="find \"$FEATURES_PATH\" -name \"*$COLLECTION""_""$TOPICS.query*.ftr\" -not -name \"*doc*\""
#time bash "../scripts/aggregate_features_query_doc.sh"
#time bash -c "echo \"$OUTPUT_PATH/$COLLECTION\"\"_\"\"$TOPICS.query_doc_aggregated.ftr\"; $find_features_command" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#time bash -c "$find_features_command" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#time bash -c "echo \"$OUTPUT_PATH/$COLLECTION\"\"_\"\"$TOPICS.query_doc_aggregated.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  >> "$OUTPUT_MATRIX"
#time bash -c "echo \"$find_features_command\";"

#if [ "$collection_name" == "CLUEWEB12B" ]
#then
#	time bash -c "echo \"output/features/$COLLECTION""_""$TOPICS.query_features_dorian.ftr\"; echo \"output/features/$COLLECTION""_""$TOPICS.query_idf_features.ftr\"; echo \"output/features/$COLLECTION""_""$TOPICS.query_features_py.ftr\"; echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#
#elif [ "$collection_name" == "CLUEWEB12B-WT13" ]
#then
#	time bash -c "echo \"output/features/$COLLECTION""_""$TOPICS.query_features_dorian.ftr\"; echo \"output/features/$COLLECTION""_""$TOPICS.query_idf_features.ftr\"; echo \"output/features/$COLLECTION""_""$TOPICS.query_features_py.ftr\"; echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFTerm_QFJSD.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#
#elif [ "$collection_name" == "CLUEWEB12B-WT14" ]
#then
#	time bash -c "echo \"output/features/$COLLECTION""_""$TOPICS.query_features_dorian.ftr\"; echo \"output/features/$COLLECTION""_""$TOPICS.query_idf_features.ftr\"; echo \"output/features/$COLLECTION""_""$TOPICS.query_features_py.ftr\"; echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFTerm_QFJSD.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#
#else
#	time bash -c "echo \"output/features/$COLLECTION""_""$TOPICS.query_features_dorian.ftr\"; echo \"output/features/$COLLECTION""_""$TOPICS.query_features_tanguy.ftr\"; echo \"output/features/$COLLECTION""_""$TOPICS.query_idf_features.ftr\"; echo \"output/features/$COLLECTION""_""$TOPICS.query_features_py.ftr\"; echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_""Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFTerm_QFJSD.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#
#fi

#if [ "$collection_name" == "CLUEWEB12B" ]
#then
#	time bash -c "echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFDOC_QFTERM_QFJSD_QFHYBRID.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#
#elif [ "$collection_name" == "CLUEWEB12B-WT13" ]
#then
#	time bash -c "echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFDOC_QFTERM_QFJSD_QFHYBRID.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#
#elif [ "$collection_name" == "CLUEWEB12B-WT14" ]
#then
#	time bash -c "echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFDOC_QFTERM_QFJSD_QFHYBRID.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#
#else
#	time bash -c "echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_""Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFDOC_QFTERM_QFJSD_QFHYBRID.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"
#
#fi


if [ "$collection_name" == "CLUEWEB12B" ]
then
	time bash -c "echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFDOC_QFTERM_QFJSD_QFHYBRID.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"

elif [ "$collection_name" == "CLUEWEB12B-WT13" ]
then
	time bash -c "echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFDOC_QFTERM_QFJSD_QFHYBRID.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"

elif [ "$collection_name" == "CLUEWEB12B-WT14" ]
then
	time bash -c "echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFDOC_QFTERM_QFJSD_QFHYBRID.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"

else
	time bash -c "echo \"output/features_merged/$COLLECTION""_""$TOPICS.query_doc_aggregated.ftr\"; echo \"output/features/$collection_name""_""Dirichlet_LM_""$TOPICS.query_NQC_UQC_WIG_QF_QFDOC_QFTERM_QFJSD_QFHYBRID.ftr\"" | "$PYTHON_PROGRAM" ../scripts/merge_features.py -w 1  > "$OUTPUT_MATRIX"

fi

