import os
import sys

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


def print_matrix_row(query_id, evaluation_fields, evaluation_values):
	"""Function used to print a row of the result matrix ."""
	print query_id + '\t',

	for evaluation_field in evaluation_fields:
		print evaluation_values.get(evaluation_field, '0.0') + '\t',
	print ''


def process_run(eval_result_filename):
	""" Function used to extract and print the matrix lines for a given run"""

	# Checking if the evaluation file exists for the current run
	if os.path.isfile(eval_result_filename):
		# Opening the evaluation file for reading
		eval_file = open(eval_result_filename)
		# Generating matrix rows from de run evaluation
		try:
			while True:
				query_id, evaluation_values = extract_trec_eval(eval_file)
				
                                if query_id is None: 
                                    break

                                print_matrix_row(query_id, trec_eval_fields, evaluation_values)
		
		except StopIteration:
			pass


def main():
	"""Main function"""
	
	if len(sys.argv) < 2:
		print 'Usage: ' + sys.argv[0] + ' teval_result_file'
		exit(1)

	eval_result_file = sys.argv[1]
	print 'requete' + '\t',

	for a_field in trec_eval_fields:
		print a_field + '\t',

	print ''

	# Formulating the matrix and write

	process_run(eval_result_file)
	print ''


main()
