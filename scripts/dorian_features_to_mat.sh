#!/bin/bash
#SBATCH --job-name=tanguy-features_to_mat
#SBATCH --output=output/logs/dorian-features_to_mat.log

source "./PARAMETERS.sh"


output_file_path="output/features/$collection_name""_""$model_name""_""$topics_range.query_features_dorian.ftr"


#time awk 'BEGIN{\
#	FS="\t";\
#	OFS="\t";\
#}{\
#	ok=0;\
#	if(NR==1){\
#		$1 = "query_id";\
#		 ok=1;\
#	}else if(index($1, "-title")>0){\
#			ok=1;\
#			gsub("-title", "", $1);\
#	} if(ok) print $0\
#}' "$dorian_features" > "$output_file_path"

time awk 'BEGIN{\
	FS="\t";\
	OFS="\t";\
}{\
	ok=0;\
	if(NR==1){\
		$1 = "query_id";\
		 ok=1;\
	}
        else if(index($1, "-title")>0){\
			ok=1;\
			gsub("-title", "", $1);\
	}
        else{
            ok=1;\
        } 
        if(ok) print $0\
}' "$dorian_features" > "$output_file_path"
