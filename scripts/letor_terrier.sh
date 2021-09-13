#!/bin/sh
# Options SBATCH :
#SBATCH --job-name=Letor_Terrier
#SBATCH --output=output/logs/letor_terrier.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --partition=64CPUNodes

source "./PARAMETERS.sh"

index_path="$terrier_index"
name="$collection_name""_""$model_name"

features_list_query_doc_file_path="input/features/""$name""_features_query-doc.list"
output_letor_query_doc_file_path="output/letor/""$name""_""$topics_range""_query-doc_terrier.letor"

features_list_doc_file_path="input/features/""$name""_features_doc.list"
output_letor_doc_file_path="output/letor/""$name""_""$topics_range""_doc_terrier.letor"

time /projets/sig/mullah/ir/tools/terrier_tools/letor_terrier.sh -i "$index_path" -t "$topics_list" -r "$output_letor_doc_file_path" -c $documents_amount -f "$features_list_doc_file_path" -m "$model_name"

time /projets/sig/mullah/ir/tools/terrier_tools/letor_terrier.sh -i "$index_path" -t "$topics_list" -r "$output_letor_query_doc_file_path" -c $documents_amount -f "$features_list_query_doc_file_path" -m "$model_name"


