import argparse
import os
import sys
import string
import numpy


parser = argparse.ArgumentParser(description='A tool used to aggregate features from query-doc into query features')
parser.add_argument('features_file', nargs='?', type=str, help='The feature file from which features must be merged')

header = [];

input_features_names = []
input_features_values = {}

output_features_names = []
output_features_values = {}

#n_grid = [5, 10, 50, 100, 500, 1000]
#n_grid = [5, 10, 25, 50, 100, 250, 500, 1000]
#n_grid = [2, 10, 100, 1000]
n_grid = [5, 10, 15, 20, 25, 50, 100, 150, 200, 250, 300, 500, 700, 1000]

features_file = None

def parse_args():
	""" Function used to parse the arguments provided to the script"""
	global features_file

	# Parsing the args
	args = parser.parse_args()

	# Retrieving the args
	features_file = args.features_file


def extract_features_names(matrix_file_name):
	global header
	first_line = next(open(matrix_file_name)).strip().split('\t')
	if len(header) == 0:
		header.append(first_line[0])
	return first_line[2:]


def complete_features(matrix_file_name, current_features):
	first_line = True
	for line in open(matrix_file_name):
		if first_line:
			first_line = False
			continue

		fields = line.strip().split('\t')
		query_id = ''
		doc_id = ''

		for field_index in range(0, len(fields)):
			if field_index == 0:
				query_id = fields[field_index].strip()
			elif field_index == 1:
				doc_id = fields[field_index].strip()
			else:
				feature_name = current_features[field_index - 2]
				feature_value = fields[field_index].strip()
				if feature_value.lower() != 'none':
					if query_id not in input_features_values.keys():
						input_features_values[query_id] = {}
					if feature_name not in input_features_values[query_id].keys():
						input_features_values[query_id][feature_name] = list()
					input_features_values[query_id][feature_name].append(float(feature_value))

def get_topk(data_list, n):
        
        l = len(data_list)
        n = min(n, l)
        data_n = data_list[:n]
    
        return data_n

def n_aggregate_features():
    
        for query_id in input_features_values:
            
            if query_id not in output_features_values.keys():
                output_features_values[query_id] = {}
            
            for feature_name in input_features_values[query_id]:
                
                for n in n_grid:
                    
                    if feature_name + '_' + str(n) + '_Q1' not in output_features_names:
                        output_features_names.append(feature_name + '_' + str(n) + '_Q1')
                        
                    if feature_name + '_' + str(n) + '_Q3' not in output_features_names:      
                        output_features_names.append(feature_name + '_' + str(n) + '_Q3')
                        
                    if feature_name + '_' + str(n) + '_mean' not in output_features_names:   
                        output_features_names.append(feature_name + '_' + str(n) + '_mean')
                        
                    if feature_name + '_' + str(n) + '_median' not in output_features_names:    
                        output_features_names.append(feature_name + '_' + str(n) + '_median')
                        
                    if feature_name + '_' + str(n) + '_std' not in output_features_names:      
                        output_features_names.append(feature_name + '_' + str(n) + '_std')
                        
                    if feature_name + '_' + str(n) + '_std2' not in output_features_names:      
                        output_features_names.append(feature_name + '_' + str(n) + '_std2')
		    
                    if feature_name + '_' + str(n) + '_numdocs' not in output_features_names:      
                        output_features_names.append(feature_name + '_' + str(n) + '_numdocs')
			
                    if feature_name + '_' + str(n) + '_min' not in output_features_names:
                        output_features_names.append(feature_name + '_' + str(n) + '_min')
			
                    if feature_name + '_' + str(n) + '_max' not in output_features_names:
                        output_features_names.append(feature_name + '_' + str(n) + '_max')
                    
                    output_features_values[query_id][feature_name + '_' + str(n) + '_Q1'] = numpy.percentile(get_topk(input_features_values[query_id][feature_name], n), 25)
                    output_features_values[query_id][feature_name +'_' + str(n) + '_Q3'] = numpy.percentile(get_topk(input_features_values[query_id][feature_name], n), 75)
                    output_features_values[query_id][feature_name + '_' + str(n) + '_mean'] = numpy.mean(get_topk(input_features_values[query_id][feature_name], n))
                    output_features_values[query_id][feature_name + '_' + str(n) + '_median'] = numpy.median(get_topk(input_features_values[query_id][feature_name], n))
                    output_features_values[query_id][feature_name + '_' + str(n) + '_std'] = numpy.std(get_topk(input_features_values[query_id][feature_name], n))
                    output_features_values[query_id][feature_name + '_' + str(n) + '_std2'] = numpy.power(numpy.nanstd(get_topk(input_features_values[query_id][feature_name], n)), 2)
                    output_features_values[query_id][feature_name + '_' + str(n) + '_numdocs'] = len(get_topk(input_features_values[query_id][feature_name], n))
                    output_features_values[query_id][feature_name + '_' + str(n) + '_max'] = numpy.max(get_topk(input_features_values[query_id][feature_name], n))
                    output_features_values[query_id][feature_name + '_' + str(n) + '_min'] = numpy.min(get_topk(input_features_values[query_id][feature_name], n))


parse_args()

current_features = extract_features_names(features_file)
for features_name in current_features:
	if features_name not in input_features_names:
		input_features_names.append(features_name)
complete_features(features_file, current_features)

n_aggregate_features();



for field in header:
    print(field, end='\t')

last_feature_idx = len(output_features_names) - 1
for idx, field in enumerate(output_features_names):
    if idx == last_feature_idx:
        print(field)
    else:
        print(field, end='\t')
print('')

for query_id in output_features_values:
    print(query_id, end='\t')
    for idx, feature_name in enumerate(output_features_names):
        feature_value = output_features_values[query_id].get(feature_name, 'none')
        if idx == last_feature_idx:
            print(feature_value)
        else:
            print(feature_value, end='\t')
    #print('')
