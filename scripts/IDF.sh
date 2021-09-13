#!/bin/bash

EXPECTED_ARGS=5
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: ./`basename $0` indriH_path index_path query_txt_file path_to_query_folder path_to_output"
  exit $E_BADARGS
fi

indriP=$1
index=$2
queries=$3
query_folder=$4
output=$5

#rm -rf ${query_folder}*

awk -F':' -v q_folder=$query_folder '{print $2 > q_folder$1}' $queries

total_docs=$(${indriP}dumpindex $index stats | tail -n +2 | head -n 1 | awk '{print $2}')

#echo $total_docs
echo -e "query_id\tidf_Q1\tidf_Q3\tidf_mean\tidf_median\tidf_std\tidf_std2\tidf_sum\tidf_max\tidf_min"
echo -e "query_id\tidf_Q1\tidf_Q3\tidf_mean\tidf_median\tidf_std\tidf_std2\tidf_sum\tidf_max\tidf_min" > $output

for query in `ls $query_folder`
do
	q_text=$(cat $query_folder$query)
	arr=$(echo $q_text | tr " " "\n")
	echo $query
	
	declare -a idf_scores
	count=0
	sum=0
	max=-1
	min=10000000
	for x in $arr
	do	
		count=$(($count+1))
		
		
    		df=$(${indriP}/dumpindex $index term $x | wc -l)
		idf=$(awk -v total=$total_docs -v df=$df 'BEGIN{print log(total/df);}')

		idf_scores[$count]=$idf
		sum=$(awk -v sum=$sum -v idf=$idf 'BEGIN{print sum+idf}')		

		max_comp=$(awk -v max=$max -v idf=$idf 'BEGIN{if(max<idf)print "t";else print "f";}')	
		if [ $max_comp = "t" ]; then 
			max=$idf
		fi
		
		min_comp=$(awk -v min=$min -v idf=$idf 'BEGIN{if(min>idf)print "t";else print "f";}')	
		if [ $min_comp = "t" ]; then 
			min=$idf
		fi
		#echo $idf
		
	done

	#echo $max
	#echo "count "$count
	#echo "sum "$sum

	avg=$(awk -v sum=$sum -v count=$count 'BEGIN{if(count!=0)print sum/count;else print "0";}')
	#echo "average "$avg

	sorted_idf=($(
        for i in ${idf_scores[*]}
        do
                echo "$i"
        done|sort -k1,1n))

	q1i=$(awk -v n=$count 'BEGIN{qi=int((n*25+99)/100)-1; print qi;}')
	q1=${sorted_idf[$q1i]}
	#echo "Q1= "$q1

	q3i=$(awk -v n=$count 'BEGIN{qi=int((n*75+99)/100)-1; print qi;}')
	q3=${sorted_idf[$q3i]}
	#echo "Q3= "$q3

	mi=$(awk -v n=$count 'BEGIN{mi=int((n+1)/2)-1;print mi;}')
	median=${sorted_idf[$mi]}
	#echo "Median= "$median

	std=0
	std2=0
	sq_sum=0

	for i in ${sorted_idf[*]}
	do
		sq_sum=$(awk -v mean=$avg -v i=$i -v ss=$sq_sum 'BEGIN{ss=ss+((i-mean)*(i-mean));print ss;}')
	done	

	std2=$(awk -v ss=$sq_sum -v n=$count 'BEGIN{if(n!=0) std2=ss/n;print std2;}')
	std=$(awk -v std2=$std2 'BEGIN{print sqrt(std2);}')

	echo -e $query"\t"$q1"\t"$q3"\t"$avg"\t"$median"\t"$std"\t"$std2"\t"$sum"\t"$max"\t"$min
	echo -e $query"\t"$q1"\t"$q3"\t"$avg"\t"$median"\t"$std"\t"$std2"\t"$sum"\t"$max"\t"$min >> $output

done

