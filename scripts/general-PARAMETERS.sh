# Sample parameter, place it in your working directory and adapt it to your computations the run sbatch ../script/__A_SCRIPT__.sh

# Collection and topic metadata
collection_name="WT10G"
model_name="BM25"
topics_range="451-550"
documents_amount="1000"

# Collection info
collection_path="/projets/sig/CORPUS/WT10G/SOURCE/"


# Indexes info
terrier_index="/projets/sig/smolina/Indexes/Terrier/WT10G"
indri_index="/projets/sig/SharedIndri/Collections/WT10G/index/"

indri_version="indri-5.3"


# Topics info
topics_list="input/topics/topics451-550.txt"
queries_indri="input/topics/topics451-550.txt.indri"


# Precomputed features
tanguy_features="input/features_tanguy/features-WT-10G.csv"
