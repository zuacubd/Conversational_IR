#!/bin/bash

source "./PARAMETERS.sh"

export TERRIER_HEAP_MEM="65536m"

index_path="$terrier_index"

topics_file_path="$topics_list"

runs_file_path="output/runs/$collection_name""_""$model_name""_""$topics_range""_""terrier.res"
mkdir -p `dirname $runs_file_path`

echo "Terrier $main_model retrieval ..."
/projets/sig/mullah/ir/tools/query_terrier/query_terrier.sh -i "$index_path" -t "$topics_file_path" -r "$runs_file_path" -c "$documents_amount" -m "$model_name"
echo "Done."
