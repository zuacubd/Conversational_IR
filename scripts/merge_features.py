import argparse
import os
import sys
import string



parser = argparse.ArgumentParser(description='A tool used to merge features matrices')
parser.add_argument('-w', '--id_width', nargs='?', type=int, required=True, help='The number of fields covered by the line id (doc = 1, query doc = 2)')


id_width = None

header = [];
features_names = []
features_values = {}

def parse_args():
	""" Function used to parse the arguments provided to the script"""
	global id_width

	# Parsing the args
	args = parser.parse_args()

	# Retrieving the args
	id_width = args.id_width


def extract_features_names(matrix_file_name, id_width):
	global header
	#print(matrix_file_name)
	first_line = next(open(matrix_file_name)).strip().split('\t')
	#print(first_line)
	if len(header) == 0:
		header.extend(first_line[:id_width])
	return first_line[id_width:]


def complete_features(features_values, matrix_file_name, current_features, id_width):
	first_line = True
	for line in open(matrix_file_name):
		if first_line:
			first_line = False
			continue

		fields = line.strip().split('\t')
		line_id = ''
		for field_index in range(0, len(fields)):
			if field_index < id_width:
				line_id = (line_id + '	' + fields[field_index]).strip()
			else:
				if line_id not in features_values:
					features_values[line_id] = {}
				features_values[line_id][current_features[field_index - id_width]] = fields[field_index].strip()


parse_args()


for line in sys.stdin:
	current_matrix_file_name = line.strip()
	#print(line)
	#print(current_matrix_file_name)
	current_features = extract_features_names(current_matrix_file_name, id_width)
	for features_name in current_features:
		if features_name not in features_names:
			features_names.append(features_name)
	complete_features(features_values, current_matrix_file_name, current_features, id_width)


for field in header:
	print(field, end='\t')
for field in features_names:
	print(field, end='\t')
print('')

for feature_id in features_values:
	print(feature_id, end='\t')
	for feature_name in features_names:
		feature_value = features_values[feature_id].get(feature_name, 'none')
		print(feature_value, end='\t')
	print('')
