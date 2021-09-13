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

eval_file_path=$eval_result_dir${trec_run_file##*/}"_eval"
eval_mat_file_path=$eval_result_dir${trec_run_file##*/}".mat"


echo "relevance file: +"$train_query_rels_judgments
echo "evaluating runs :"$trec_run_file

echo "writing results '"$eval_file_path
/projets/sig/mullah/qpp/dependencies/trec_eval.9.0/trec_eval -q -m $measure $train_query_rels_judgments $trec_run_file > $eval_file_path
#/projets/sig/mullah/qpp/dependencies/trec_eval.8.1/trec_eval -q -c -m ndcg $query_rels_judgments $trec_run_file > $eval_file_path
echo "done"

echo "writing topic-by-evaluation matrix to :"$eval_mat_file_path
/logiciels/Python-2.7.13/bin/python scripts/eval_trec_result2mat.py "$eval_file_path" > "$eval_mat_file_path" 
echo "done"
