import os
import sys

available_properties = [
	'blocs',
	'blocs.type',
	'blocs.size',
	'blocs.delimiter',
	'max.blocs',
	'indexing.max.tokens',
	'max.term.length',
	'ignore.empty.documents',
	'stemmer',
	'retrieving.model',
	'TrecQueryTags.process',
	'TrecQueryTags.skip',
	'ignore.low.idf.terms',
    'parameter.free.expansion',
    'trec.qe.model',
    'expansion.documents',
    'expansion.terms',
    'expansion.mindocuments'
]

ndeval_fields = [
	'ERR-IA@5',
	'ERR-IA@10',
	'ERR-IA@20',
	'nERR-IA@5',
	'nERR-IA@10',
	'nERR-IA@20',
	'alpha-DCG@5',
	'alpha-DCG@10',
	'alpha-DCG@20',
	'alpha-nDCG@5',
	'alpha-nDCG@10',
	'alpha-nDCG@20',
	'NRBP',
	'nNRBP',
	'MAP-IA',
	'P-IA@5',
	'P-IA@10',
	'P-IA@20',
	'strec@5',
	'strec@10',
	'strec@20'
]

trec_eval_fields = [
	'11pt_avg',
	'P_1',
	'P_10',
	'P_100',
	'P_1000',
	'P_15',
	'P_2',
	'P_20',
	'P_200',
	'P_30',
	'P_5',
	'P_50',
	'P_500',
	'Rndcg',
	'Rprec',
	'bpref',
	'iprec_at_recall_0.00',
	'iprec_at_recall_0.10',
	'iprec_at_recall_0.20',
	'iprec_at_recall_0.30',
	'iprec_at_recall_0.40',
	'iprec_at_recall_0.50',
	'iprec_at_recall_0.60',
	'iprec_at_recall_0.70',
	'iprec_at_recall_0.80',
	'iprec_at_recall_0.90',
	'iprec_at_recall_1.00',
	'map',
	'ndcg',
	'ndcg_cut_10',
	'ndcg_cut_100',
	'ndcg_cut_1000',
	'ndcg_cut_15',
	'ndcg_cut_20',
	'ndcg_cut_200',
	'ndcg_cut_30',
	'ndcg_cut_5',
	'ndcg_cut_500',
	'ndcg_rel',
	'num_rel',
	'num_rel_ret',
	'num_ret',
	'recall_1',
	'recall_10',
	'recall_100',
	'recall_1000',
	'recall_15',
	'recall_2',
	'recall_20',
	'recall_200',
	'recall_30',
	'recall_5',
	'recall_50',
	'recall_500',
	'recip_rank',
	'relative_P_1',
	'relative_P_10',
	'relative_P_100',
	'relative_P_1000',
	'relative_P_15',
	'relative_P_2',
	'relative_P_20',
	'relative_P_200',
	'relative_P_30',
	'relative_P_5',
	'relative_P_50',
	'relative_P_500',
	'set_F',
	'set_P',
	'set_map',
	'set_recall',
	'set_relative_P',
	'success_1',
	'success_10',
	'success_5'
]

stemmers_2_compact = {
	'DanishSnowballStemmer': 'DSS',
	'DutchSnowballStemmer': 'DSS',
	'EnglishSnowballStemmer': 'ESS',
	'FinnishSnowballStemmer': 'FSS',
	'FrenchSnowballStemmer': 'FSS',
	'GermanSnowballStemmer': 'GSS',
	'HungarianSnowballStemmer': 'HSS',
	'ItalianSnowballStemmer': 'ISS',
	'NorwegianSnowballStemmer': 'NSS',
	'PorterStemmer': 'PS',
	'PortugueseSnowballStemmer': 'PSS',
	'RomanianSnowballStemmer': 'RSS',
	'RussianSnowballStemmer': 'RSS',
	'SnowballStemmer': 'SS',
	'SpanishSnowballStemmer': 'SSS',
	'StemmerTermPipeline': 'STP',
	'SwedishSnowballStemmer': 'SSS',
	'TRv2PorterStemmer': 'TRPS',
	'TRv2WeakPorterStemmer': 'TRWPS',
	'TurkishSnowballStemmer': 'TSS',
	'WeakPorterStemmer': 'WPS'
}

def load_available_properties(root_path):
	"""loads the available properties from the files in a given path."""
	# Initialising an empty set in order to store the properties names
	properties = set()
	# Going through all the run folders

	for current_path, _, files in os.walk(root_path):
	    for filename in files:
			# Reconstructing the configuration file name
			if filename.endswith('.properties') or filename.endswith('.settings'):
				properties_filename = os.path.join(current_path, filename)
				# Checking if the configuration file exists
				if os.path.isfile(properties_filename):
					# Opening the configuration file for reading
					properties_file = open(properties_filename)
					# Going through the file lines
					for property_line in properties_file:
						# Removing leading and trailing whitespaces
						property_line = property_line.strip()
						# Checking if the line is valid
						if not property_line.startswith('#') and len(property_line) > 0:
							# Adding the configuration key to the parameters set
							property_name = property_line.split('=')[0].strip()
							available_properties.add(property_name)

	# Converting the parameter set to a list
	properties_as_list = list(properties)
	# Sorting the parameters names
	properties_as_list.sort()
	# Returing the sorted parameters list
	return properties_as_list

def extract_terrier_properties(properties_filename):
	""" Function used to extract the necessary properties from a terrier properties file """
	# Initialising a dictionnary in order to store the configuration for the current run
	properties = {}

	# Opening the configuration file for reading
	properties_file = open(properties_filename)

	# Reading the configuration values for the current run
	for property_line in properties_file:

		if not property_line.startswith('#') and len(property_line) > 0:
			property_name = property_line.split('=')[0].strip()
			property_value = property_line.split('=')[1].strip()
			properties[property_name] = property_value if len(property_value) > 0 else 'none'

	## Begin of the fixes in order to match the names chosen by Anthony Bigot'

	properties['max.blocks'] = properties.get('blocks.max', 'none')
	properties['blocks.type'] = 'blocs_size' if 'blocks.size' in properties else 'none'
	properties['blocks.delimiter'] = properties.get('block.delimiters', 'none')
	properties['retrieving.model'] = properties.get('trec.model', 'none')
	properties['parameter.free.expansion'] = properties.get('parameter.free.expansion' , 'none').upper()
	properties['trec.qe.model'] = properties.get('trec.qe.model', 'none')
	properties['expansion.documents'] = properties.get('expansion.documents', 'none')
	properties['expansion.terms'] = properties.get('expansion.terms', 'none')
	properties['expansion.mindocuments'] = properties.get('expansion.mindocuments', 'none')

	if '/Retrieving/' in properties_filename:
		properties['trec.qe.model'] = 'none'
		properties['expansion.documents'] = 'none'
		properties['expansion.terms'] = 'none'

	if 'indexing.max.tokens' in properties and properties['indexing.max.tokens'] != 'none':
		properties['indexing.max.tokens'] = properties['indexing.max.tokens']
	else:
		properties['indexing.max.tokens'] = 'Infinite'

	if 'blocks.size' in properties and properties['blocks.size'] != 'none':
		properties['blocks'] = 'TRUE'
	else:
		properties['blocks'] = 'FALSE'

	if 'parameter.free.expansion' in properties and properties['parameter.free.expansion'] == 'none':
		properties['parameter.free.expansion'] = 'FALSE'

	if 'trec.qe.model' in properties and properties['trec.qe.model'] == 'none':
		properties['trec.qe.model'] = '0'

	if 'expansion.documents' in properties and properties['expansion.documents'] == 'none':
		properties['expansion.documents'] = '0'

	if 'expansion.terms' in properties and properties['expansion.terms'] == 'none':
		properties['expansion.terms'] = '0'

	if 'expansion.mindocuments' in properties and properties['expansion.mindocuments'] == 'none':
		properties['expansion.mindocuments'] = '0'

	properties['stemmer'] = 'none'
	for pipeline_item in properties['termpipelines'].split(','):
		properties['stemmer'] = stemmers_2_compact.get(pipeline_item.strip(), properties['termpipelines'])

	## End of the fixes in order to match the names chosen by Anthony Bigot

	return properties


def extract_trec_eval(evaluation_file):
	""" Function used the evaluation values of a trec_eval result file """
	query_id = None
	query_evaluation_values = {}
	for line in evaluation_file:
		line_fields = line.split()
		if query_id is None:
			query_id = line_fields[1]
			if query_id == 'all':
				raise StopIteration
		elif line_fields[1] != query_id:
			break
		query_evaluation_values[line_fields[0]] = line_fields[2]
	return (query_id, query_evaluation_values)

def extract_ndeval(fields_order, evaluation_file):
	""" Function used the evaluation values of a ndeval result file """
	# Reading the evaluation line
	line = evaluation_file.next()

	# Creating a dictionnary to the evaluation values from the score fields and the current line scores
	query_evaluation_values = dict(zip(fields_order, line.split(',')))

	# Getting the query id
	query_id = query_evaluation_values['topic']

	if query_id == 'amean':
		raise StopIteration

	# Removing non score values
	query_evaluation_values.pop('runid', None)
	query_evaluation_values.pop('topic', None)

	return (query_id, query_evaluation_values)


def print_matrix_row(properties, query_id, evaluation_fields, evaluation_values):
	"""Function used to print a row of the result matrix ."""
	for property_name in available_properties:
		property_name_alt = property_name.replace('bloc', 'block')
		print properties.get(property_name, properties.get(property_name_alt, 'none')) + '\t',

	print query_id + '\t',

	for evaluation_field in evaluation_fields:
		print evaluation_values.get(evaluation_field, '0.0') + '\t',
	print ''


def process_run(properties_filename, eval_filename, eval_program):
	""" Function used to extract and print the matrix lines for a given run"""

	# Extracting the properties contained in the current configuration file
	properties = extract_terrier_properties(properties_filename)

	# Checking if the evaluation file exists for the current run
	if os.path.isfile(eval_filename):
		# Opening the evaluation file for reading
		eval_file = open(eval_filename)
		# Generating matrix rows from de run evaluation
		try:
			# Read header for the ndeval eval files in order to guarantee the right order
			if eval_program == 'ndeval':
				order = eval_file.next().split(',')
			while True:
				# Extracting the next matrix row
				if eval_program == 'ndeval':
					query_id, evaluation_values = extract_ndeval(order, eval_file)
					print_matrix_row(properties, query_id, ndeval_fields, evaluation_values)
				else:
					query_id, evaluation_values = extract_trec_eval(eval_file)
					print_matrix_row(properties, query_id, trec_eval_fields, evaluation_values)
		except StopIteration:
			pass


def main():
	"""Main function"""
	if len(sys.argv) < 3:
		print 'Usage: ' + sys.argv[0] + ' ndeval/trec_eval properties_path [evaluations_path]'
		exit(1)
	eval_program = sys.argv[1]
	properties_path = sys.argv[2]

	if len(sys.argv) == 4:
		evaluations_path = sys.argv[3]
	else:
		evaluations_path = properties_path

	#available_properties = load_available_properties(path)

	# Printing the header
	for a_property in available_properties:
		print a_property.replace('.', '_') + '\t',

	print 'requete' + '\t',

	if eval_program == 'ndeval':
		for a_field in ndeval_fields:
			print a_field + '\t',
	else:
		for a_field in trec_eval_fields:
			print a_field + '\t',

	print ''

	# Finding configuration files for each run
	for current_path, _, files in os.walk(properties_path):
	    for filename in files:
			# Checking if the current file is a configuration file
			if filename.endswith('.properties') or filename.endswith('.settings'):
				# Reconstructing the configuration file name
				properties_filename = os.path.join(current_path, filename)

				# Reconstructing the evaluation file name
				evaluation_filename = properties_filename.replace(properties_path, evaluations_path)
				evaluation_filename = evaluation_filename.replace('.properties', '.eval')
				evaluation_filename = evaluation_filename.replace('.settings', '.eval')

				# Checking if the configuration file exists
				if os.path.isfile(properties_filename) and os.path.isfile(evaluation_filename):
					process_run(properties_filename, evaluation_filename, eval_program)
	print ''


main()
