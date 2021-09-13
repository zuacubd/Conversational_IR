#!/bin/bash

EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: ./`basename $0` query_txt_file_original query_txt_file_csv"
  exit $E_BADARGS
fi

topic_original_file=$1
topic_formated_file=$2

echo "Reading from :"$topic_original_file
echo "Writing to :"$topic_formated_file

awk -v input_file=$topic_original_file -v output_file=$topic_formated_file 'BEGIN{
	idx=1;


	while(getline < input_file)
	{	
		split($0,ft," ");		
	
		if(length(ft)>2)
		{
			if(ft[1]=="<num>"){
				topic_id[idx]=ft[3];
			}
		}
	
		if(length(ft)>=2)
		{	
			if(ft[1]=="<title>")
			{
				topic_string=ft[2];
				for(i=3; i<=length(ft); i++)
				{	topic_string=topic_string " " ft[i];
				
				}
				print topic_id[idx]":"topic_string;
				topic_title[idx++]=topic_string;
			}
		}
	}
	close(input_file);		

	n = length(topic_id);

	for(idx=1; idx<=n; idx++)
	{
		print topic_id[idx]":"topic_title[idx] > output_file;
	}
	print "Done."
}'

