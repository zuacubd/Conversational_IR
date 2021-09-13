#!/bin/bash
#SBATCH --job-name=tanguy-features_to_mat
#SBATCH --mail-type=END
#SBATCH --output=output/logs/tanguy-features_to_mat.log

source "./PARAMETERS.sh"


output_file_path="output/features/$collection_name""_""$model_name""_""$topics_range.query_features_tanguy.ftr"


time awk 'BEGIN{\
	FS="\t";\
	OFS="\t";\
}{\
	ok=0;\
	if(NR==1){\
		$1 = "query_id";\
		 ok=1;\
	}else if(index($1, "-title")>0){\
			ok=1;\
			gsub("-title", "", $1);\
	} if(ok) print $0\
}' "$tanguy_features" > "$output_file_path"
