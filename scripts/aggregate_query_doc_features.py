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

def aggregate_features():
	for query_id in input_features_values:
		if query_id not in output_features_values.keys():
			output_features_values[query_id] = {}
		for feature_name in input_features_values[query_id]:
			if feature_name + '_Q1' not in output_features_names:
				output_features_names.append(feature_name + '_Q1')
			if feature_name + '_Q3' not in output_features_names:      
				output_features_names.append(feature_name + '_Q3')
			if feature_name + '_mean' not in output_features_names:   
				output_features_names.append(feature_name + '_mean')
			if feature_name + '_median' not in output_features_names:      
				output_features_names.append(feature_name + '_median')
			if feature_name + '_std' not in output_features_names:      
				output_features_names.append(feature_name + '_std')
			if feature_name + '_std2' not in output_features_names:      
				output_features_names.append(feature_name + '_std2')
			if feature_name + '_numdocs' not in output_features_names:      
				output_features_names.append(feature_name + '_numdocs')
			if feature_name + '_min' not in output_features_names:
				output_features_names.append(feature_name + '_min')
			if feature_name + '_max' not in output_features_names:
				output_features_names.append(feature_name + '_max')

			output_features_values[query_id][feature_name + '_Q1'] = numpy.percentile(input_features_values[query_id][feature_name], 25)
			output_features_values[query_id][feature_name + '_Q3'] = numpy.percentile(input_features_values[query_id][feature_name], 75)
			output_features_values[query_id][feature_name + '_mean'] = numpy.mean(input_features_values[query_id][feature_name])
			output_features_values[query_id][feature_name + '_median'] = numpy.median(input_features_values[query_id][feature_name])
			output_features_values[query_id][feature_name + '_std'] = numpy.std(input_features_values[query_id][feature_name])
			output_features_values[query_id][feature_name + '_std2'] = numpy.power(numpy.nanstd(input_features_values[query_id][feature_name]), 2)
			output_features_values[query_id][feature_name + '_numdocs'] = len(input_features_values[query_id][feature_name])
			output_features_values[query_id][feature_name + '_max'] = numpy.max(input_features_values[query_id][feature_name])
			output_features_values[query_id][feature_name + '_min'] = numpy.min(input_features_values[query_id][feature_name])


parse_args()

current_features = extract_features_names(features_file)
for features_name in current_features:
	if features_name not in input_features_names:
		input_features_names.append(features_name)
complete_features(features_file, current_features)

aggregate_features();


for field in header:
	print(field, end='\t')
for field in output_features_names:
	print(field, end='\t')
print('')

for query_id in output_features_values:
	print(query_id, end='\t')
	for feature_name in output_features_names:
		feature_value = output_features_values[query_id].get(feature_name, 'none')
		print(feature_value, end='\t')
	print('')
