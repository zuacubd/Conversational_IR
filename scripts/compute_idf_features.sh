#!/bin/bash

source ./PARAMETERS.sh

echo "Starting computing features ... "
bash ../scripts/IDF.sh "/projets/sig/mullah/qpp/dependencies/""$indri_version""/dumpindex/" $indri_index $topics_original_list $query_folder $query_idf_features
echo "Done."

