#!/bin/bash

EXPECTED_ARGS=1
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: ./`basename $0` trec_run_file"
  exit $E_BADARGS
fi

trec_run_file=$1
source ./PARAMETERS.sh

eval_file_path=$eval_result_dir${trec_run_file##*/}".ndeval"
eval_mat_file_path=$eval_result_dir${trec_run_file##*/}".ndeval.mat"

echo "relevance file: :"$query_rels_judgments_diversity
echo "evaluating runs :"$trec_run_file

echo "writing results "$eval_file_path
/projets/sig/mullah/ir/projects/l2aranksc/Calmip-scripts/BATCH_TREC_EVAL/bin/ndeval/ndeval $query_rels_judgments_diveristy $trec_run_file > $eval_file_path
#/projets/sig/mullah/ir/projects/l2aranksc/Calmip-scripts/BATCH_TREC_EVAL/bin/ndeval/ndeval $query_rels_judgments_diveristy $trec_run_file
echo "done"

echo "writing topic-by-evaluation matrix to :"$eval_mat_file_path
/logiciels/Python-3.5.2/python ../scripts/eval_ndeval_result2mat.py "$eval_file_path" > "$eval_mat_file_path" 
echo "done"
