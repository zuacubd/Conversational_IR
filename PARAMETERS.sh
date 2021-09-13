# Basic preparation
mkdir -p 'output/logs'
#mkdir -p 'output/features'
#mkdir -p 'output/features/letor'
#mkdir -p 'output/features_merged'
mkdir -p 'output/runs'
#mkdir -p 'query_folder'
mkdir -p 'output/eval'

# Collection and topic metadata
collection_name="TREC-CAST"
#model_name="BM25"
train_topics_range="1_30"
documents_amount="1000"

# Collection info
#collection_path="IGNORE IF NOT WEB"

# Indexes info
#terrier_index="/projets/learnrank/Calmip-scripts/TREC7-8-index-blocks/"
terrier_index="/projets/sig/mullah/ir/indexer/terrier/Clueweb09B-index/"
#indri_index="/projets/sig/smolina/Indexes/Indri/Robust_store/"
indri_index="/projets/sig/mullah/ir/indexer/indri/MSMARCO_CAR_WAPO/"
#indri_index="/logiciels/indri/bin"
indri_version="indri-5.11"


# Topics info
#topics_original_list="input/topics/04.testset.csv"
topics_list="input/topics/04.testset"
train_queries_indri_lm="input/topics/train_topics_lm.query"
train_queries_indri_baseline="input/topics/train_topics_baseline.query"


# Word embedding
#word_embedding_model="output/word_embedding/word2vec_model"


#Query folder
#query_folder="query_folder/"

# Precomputed features
#tanguy_features="input/features_tanguy/features-robust.csv"
#dorian_features="input/features_dorian/04.testset_q1-q3-mean-median-std-std2-total-minimum-maximum_features.csv"

#Query idf features
#query_idf_features="output/features/"$collection_name"_"$model_name"_"$topics_range".query_idf_features.ftr"

#Relevance judgments file
train_query_rels_judgments="input/qrels/train_topics_mod.qrel"

#Stopwords file
#stopword_file_path="input/resource/stoplist.dft"

#document ids list
#document_ids="input/document_iids/document_ids"

#Evaluation measures
measure="all_trec"

#Evaluation results
eval_result_dir="output/eval/"
