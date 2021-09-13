!/bin/bash
#SBATCH --job-name=pagerank_compute
#SBATCH --mail-type=END
#SBATCH --output=pagerank_compute.log

source "./PARAMETERS.sh"
echo "$collection_path" "$indri_index" "$collection_name"
../scripts/compute_pagerank.sh "$collection_path" "$indri_index" "$collection_name" "$indri_version" output/pagerank
